class SessionsController < ApplicationController
  def new; end

  def create
    user = User.by_email_or_username(params[:email_or_username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to (session[:previous_url] || user),
                  notice: "Welcome back, #{user.name}!"
      session[:previous_url] = nil
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path, notice: 'You have successfully signed out.'
  end
end
