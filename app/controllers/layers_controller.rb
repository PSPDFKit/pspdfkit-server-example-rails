# frozen_string_literal: true

class LayersController < ApplicationController
  before_action :authorize

  rescue_from ActiveRecord::RecordNotFound, with: :document_not_found

  def index
    redirect_to(documents_path)
  end

  def create
    @document = Document.find(params[:document_id])
    @layers = DocumentEngine.document_layers(@document)
    @layer = params[:layer].presence

    if @layer
      unless @layers.include?(@layer)
        DocumentEngine.create_layer(@document, @layer)
      end

      redirect_to(document_layer_path(@document, @layer))
    else
      redirect_to(@document)
    end
  end

  def show
    @document = Document.find(params[:document_id])
    @layers = DocumentEngine.document_layers(@document)
    @layer = params[:layer].presence

    unless @layer.present? && @layers.include?(@layer)
      redirect_to(@document)
      return
    end

    if current_user.access?(@document)
      if params[:instant].present?
        session[:instant] = params[:instant] == "true"
      end
    else
      render(:unauthorized, status: :forbidden)
    end

    render(template: "documents/show")
  end

  private
    def document_not_found
      redirect_to(documents_path)
    end
end
