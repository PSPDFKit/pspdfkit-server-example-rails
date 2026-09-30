# frozen_string_literal: true

module DocumentEngine
  extend self

  attr_reader :internal_url
  attr_reader :external_url

  def configure(internal_url:, external_url:, auth_token:, jwt_key:)
    @internal_url = internal_url
    @external_url = external_url

    options = {
      url: internal_url,
      ssl: {
        verify: false
      },
      headers: {
        "Authorization" => "Token token=#{auth_token}"
      }
    }

    @client = Faraday.new(options) do |faraday|
      faraday.request :json
      faraday.response :json
    end

    @jwt_key = jwt_key
  end

  def upload_document(path)
    response = client.post("api/documents",
      File.open(path),
      {
        "Content-Length" => File.size(path).to_s,
        "Content-Type" => "application/pdf"
      }
    )

    doc = response.body

    {
      id: dig(doc, "data", "document_id"),
      title: dig(doc, "data", "document_properties", "title")
    }
  end

  def delete_document(document)
    # Deletion of a document is done on two steps:
    #
    #  1. We delete the document from Nutrient Document Engine using the
    #     DELETE endpoint.
    #
    #  2. When the deletion was successful, we also remove the database
    #     entry.
    #
    # This way, we can be sure that we don't remove a document from our
    # database that is not yet removed from the Document Engine.
    response = client.delete("api/documents/#{document.server_id}")

    return unless response.success?

    document.destroy
  end

  def document_layers(document)
    response = client.get("api/documents/#{document.server_id}/layers")
    return unless response.success?

    layers = response.body["data"]

    layers.insert(0, "")
  end

  def create_layer(document, name)
    return unless name.present?

    client.post("api/documents/#{document.server_id}/layers", { name: name })
  end

  def cover_image_url(id, dim, size)
    raise(ArgumentError, "Invalid dimension") unless %i[width height].include?(dim)
    raise(ArgumentError, "Invalid size") unless size.to_i.between?(1, 1024)

    URI.parse(@external_url).tap do |u|
      u.path = "/documents/#{id}/cover"
      u.query = {
        "jwt" => jwt_sign({ document_id: id, permissions: ["cover-image"] }),
        dim => size
      }.to_query
    end.to_s
  end

  def jwt_sign(payload)
    JWT.encode(
      payload.merge(exp: Time.now.to_i + (60 * 60)),
      jwt_key,
      "RS256"
    )
  end

  private
    def jwt_key
      @jwt_key || raise("Please call DocumentEngine#configure")
    end

    def client
      @client || raise("Please call DocumentEngine#configure")
    end

    def dig(hash, *keys)
      keys.inject(hash) { |h, k| h.is_a?(Hash) ? h[k] : nil }
    end
end
