module ApplicationHelper
  def instant_enabled?
    session[:instant] == true
  end
end
