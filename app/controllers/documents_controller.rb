class DocumentsController < ApplicationController
  before_action :authorize

  # rescue_from ActiveRecord::RecordNotFound do
  #   render :unauthorized, status: :forbidden
  # end

  def index
    @documents = current_user.accessible_documents
  end

  def create
    unless params[:document].try(:tempfile).present?
      redirect_to new_document_path
      return
    end

    result = PSPDFKit.upload_document(params[:document].tempfile)

    document = Document.create(
      owner: current_user,
      server_id: result[:id],
      title: result[:title].presence || File.basename(params[:document].original_filename, ".pdf") || "Untitled"
    )

    redirect_to documents_path
  end

  def show
    @document = Document.find(params[:id])
    if current_user.has_access?(@document)
      if params[:instant].present?
        session[:instant] = params[:instant] == 'true'
      end
    else
     render :unauthorized, status: :forbidden
    end
  end

  def share
    document = Document.find params[:id]
    new_user_ids = (params[:users] || []).map(&:to_s)
    document.user_ids = new_user_ids

    redirect_to document
  end
end
