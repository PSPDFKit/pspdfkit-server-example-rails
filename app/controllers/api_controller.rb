# frozen_string_literal: true

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, _password|
      @current_user ||= User.by_name(username)
      # only check for existence of username
      username ? true : false
    end
  end

  def documents
    documents = @current_user.accessible_documents.map do |d|
      layers = DocumentEngine.document_layers(d)
      if layers.empty?
        # Layers are created lazily, when there is a change.
        # Ensure we always report at least the default layer.
        layers = [""]
      end
      new_d = d.as_json.symbolize_keys
      new_d[:layers] = layers
      new_d[:tokens] = layers.map { |name| d.get_jwt(name) }
      new_d
    end

    documents = documents.map do |d|
      { id: d[:id].to_s, title: d[:title], layers: d[:layers], tokens: d[:tokens] }
    end

    render(json: { documents: documents })
  end

  def document
    layer = params[:layer] || ""
    document = Document.find(params[:id])
    if @current_user.access?(document)
      render(json: { success: true, token: document.get_jwt(layer) })
    else
      render(json: { success: false, message: "You don't have access to this document" })
    end
  end

  def share
    document = Document.find(params[:document_id])
    if current_user.access?(document)
      user_names = params[:users]
      users = []
      user_names.each do |username|
        users.push(User.by_name(username))
      end
      document.users = users
      render(json: { success: true, message: "Sucessfully shared document" })
    else
      render(text: "Forbidden Request", status: :forbidden)
    end
  end

  def upload
    unless params[:file].try(:tempfile).present?
      render(text: "Bad Request", status: :bad_request)
      return
    end

    result = DocumentEngine.upload_document(params[:file].tempfile)

    Document.create(
      owner: @current_user,
      server_id: result[:id],
      title: result[:title].presence || File.basename(params[:file].original_filename, ".pdf") || "Untitled"
    )

    render(json: { success: true })
  end
end
