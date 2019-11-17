class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id == current_user.id
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to @posts
    else
      redirect_to root_path
    end
  end
end
