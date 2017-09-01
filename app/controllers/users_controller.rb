class UsersController < ApplicationController

  def authenticate
    user = User.by_name(params[:user][:name])
    session[:user_id] = user.id
    redirect_to documents_path
  end

  def logout
    session.delete(:user_id)
    redirect_to '/login'
  end

end
