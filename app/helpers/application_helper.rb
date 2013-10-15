module ApplicationHelper
  def logged_in?
    !!self.current_user
  end
  
  def current_user
    @current_user ||= User.find_by_token(session[:seesion_token])
  end
  
  def login(user)
    session[:session_token] = user.reset_session_token
    user.save
  end
  
  def logout
    session[:session_token] = nil
    user.reset_session_token
    user.save
  end
end
