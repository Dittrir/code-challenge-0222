class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:id])
    @comment = @post.comments.new(comment_params)
  end

  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.new(comment_params.merge(post_id: @post.id, user_id: session[:user_id]))
    if @comment.save
      redirect_to root_path
    else
      render :new
    end
  end

private
  def comment_params
    params.permit(:body)
  end
end
