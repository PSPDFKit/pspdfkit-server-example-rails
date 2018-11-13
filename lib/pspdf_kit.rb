module PSPDFKit
  extend self

  attr_reader :internal_url
  attr_reader :external_url

  def configure(internal_url:, external_url:, auth_token:, jwt_key:)
    @internal_url = internal_url
    @external_url = external_url
    @client = RestClient::Resource.new(
      internal_url,
      verify_ssl: OpenSSL::SSL::VERIFY_NONE,
      headers: {"Authorization" => "Token token=#{auth_token}"}
    )
    @jwt_key = jwt_key
  end

  def upload_document(path)
    # call the PSPDFKit Server api endpoint "POST api/documents/" to upload a new document
    response = client["api/documents"].post(
      File.read(path),
      content_type: "application/pdf"
    )
    doc = JSON.parse(response.body)

    { id: dig(doc, "data", "document_id"), title: dig(doc, "data", "document_properties", "title") }
  end

  def delete_document(document)
    # Deletion of a document is done on two steps:
    #  1. We delete the document from PSPDFKit Server using the DELETE endpoint.
    #  2. When the deletion was successful, we also remove the database entry.
    #
    # This way, we can be sure that we don't remove a document from our database that is not yet removed from the Server.
    response = client["api/documents/#{document.server_id.to_s}"].delete()
    # When PSPDFKit Server returns status code 200 OK delete the document from the database.
    if response.code
      document.destroy
    end
  end

  def document_layers(document)
    response = client["api/documents/#{document.server_id.to_s}/layers"].get()
    if response.code
      JSON.parse(response.body)["data"]
    end
  end

  def cover_image_url(id, dim, size)
    raise(ArgumentError, "Invalid dimension") unless %i(width height).include?(dim)
    raise(ArgumentError, "Invalid size") unless size.to_i.between?(1,1024)

    URI.parse(@external_url).tap do |u|
      u.path = "/documents/#{id}/cover"
      u.query = {
        "jwt" => jwt_sign({document_id: id, permissions: ["cover-image"]}),
        dim => size
      }.to_query
    end.to_s
  end

  def jwt_sign(payload)
    JWT.encode(
      payload.merge(exp: Time.now.to_i + 60*60),
      jwt_key,
      'RS256'
    )
  end

private

  def jwt_key
    @jwt_key || raise("Please call PSPDFKit.configure()")
  end

  def client
    @client || raise("Please call PSPDFKit.configure()")
  end

  def dig(hash, *keys)
    keys.inject(hash) { |h,k| h.is_a?(Hash) ? h[k] : nil }
  end
end
