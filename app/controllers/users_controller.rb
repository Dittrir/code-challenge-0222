class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(session[:user_id])
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path(user.id)
    else
      render :new
    end
  end

private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role, :description, :age)
  end
end
