class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_basic() do |username, password|
      @current_user ||= User.by_name(username)
      # only check for existence of username
      username ? true : false
    end
  end

  def documents
    documents = @current_user.accessible_documents
    render json: {documents: documents.map {|d| {id: d[:id], title: d[:title] }}}
  end

  def document
    document = Document.find(params[:id])
    if @current_user.has_access?(document)
      jwt = PSPDFKit.jwt_sign({
        document_id: document.server_id,
        permissions: [
          'read-document',
          'write',
          'download'
        ]
      })
      render json: {success: true, jwt: jwt}
    else
     render :unauthorized, status: :forbidden
    end
  end

  def share
    document = Document.find(params[:document_id])
    if current_user.has_access?(document)
      user_names = params[:users]
      users = []
      user_names.each do |username|
        users.push(User.by_name(username))
      end
      document.users = users
      render json: {success: true, message: "Sucessfully shared document"}
    else
     render text: "Forbidden Request", status: :forbidden
    end
  end

  def upload
    unless params[:file].try(:tempfile).present?
      render text: "Bad Request", status: :bad_request
      return
    end

    result = PSPDFKit.upload_document(params[:file].tempfile)

    document = Document.create(
      owner: @current_user,
      server_id: result[:id],
      title: result[:title].presence || File.basename(params[:file].original_filename, ".pdf") || "Untitled"
    )

    render json: {success: true}
  end
end
