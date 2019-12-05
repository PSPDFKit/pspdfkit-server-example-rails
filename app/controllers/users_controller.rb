class UsersController < ApplicationController

  def authenticate
    user = User.by_name(params[:user][:name])
    session[:user_id] = user.id

    # When the user doesn't have any PDF we upload a sample document.
    if user.accessible_documents.size == 0
      result = PSPDFKit.upload_document(
        File.join(File.dirname(__FILE__), "../../assets/example.pdf")
      )

      Document.create(
        owner: user,
        server_id: result[:id],
        title: "Example"
      )
      redirect_to documents_path
      return
    end

    redirect_to documents_path
  end

  def logout
    session.delete(:user_id)
    redirect_to '/login'
  end

end
