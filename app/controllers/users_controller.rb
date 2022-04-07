class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :destroy, :update]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thank you for signing up!"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      redirect_to movies_url, danger: "Account was successfully deleted."
    else
      flash.now[:alert] = "There was a problem deleting your account."
      render :show
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :username, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
