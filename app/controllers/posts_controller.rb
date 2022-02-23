class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.find(params[:id])
    binding.pry
    comment = @post.comments.new(post_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path(@user.id)
    else
      render :new
    end
  end

  private
    def post_params
      params.permit(:title, :body)
    end
end
