class ApplicationController < ActionController::Base
  add_flash_types :danger

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def current_user_admin?(user = current_user)
    user&.admin?
  end

  helper_method :current_user
  helper_method :current_user?
  helper_method :current_user_admin?

  def require_signin
    unless current_user
      session[:previous_url] = request.url
      redirect_to signin_path, alert: 'Please sign in first!'
    end
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_path, alert: 'Unauthorized access!'
    end
  end
end
