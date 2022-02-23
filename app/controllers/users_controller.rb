class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(session[:user_id])
  end

  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path(@user.id)
    else
      render :new
    end
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user == nil
      flash[:error] = "User does not exist. Please try again."
      redirect_to "/login"
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to dashboard_path
    else
      flash[:error] = "Email or password is incorrect. Please try again."
      redirect_to "/login"
    end
  end

  def logout
    session.destroy
    redirect_to root_path
  end

private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role, :description, :age)
  end
end
