
module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Logs the current user out.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Remembers the given user in a persistent session.
  def remember(user)
    user.set_remember_token()
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget_remember_token() if not user == nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns the user corresponding to the remember-token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.valid_remember_token?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    return @current_user
  end

  # Returns `true` if the user is logged in, or `false` otherwise.
  def logged_in?
    return !(current_user.nil?)
  end

end

