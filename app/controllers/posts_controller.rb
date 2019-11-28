class PostsController < ApplicationController
  before_action :logged_in_user, only:[:index,:show,:create,:destroy]
  before_action :correct_user, only:[:destroy]
  

  #投稿表示
  def index
    @posts = Post.all
    @post = Post.new
  end

  #投稿詳細
  def show
    @post = Post.find(params[:id])
  end

   #コメントの投稿
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to user_path(current_user)
    else 
      @feed_items = []
      render 'static_pages/home'
    end
  end

  #投稿の削除
  def destroy
    @post.destroy
    flash[:success] = "削除しました"
    redirect_to request.referrer || user_path(current_user)
  end

  private

  #投稿を受け取る
  def post_params
    params.require(:post).permit(:content,:picture)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to user_path(current_user) if @post.nil?
end
end