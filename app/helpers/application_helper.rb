module ApplicationHelper
  def logged_in?
    !!self.current_user
  end

  def current_user
    @current_user ||= User.find_by_token(session[:session_token])
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

  def authenticate
    # use with before_filter
    redirect_to new_session_url unless logged_in?
  end
end
