class UsersController < ApplicationController
before_action :logged_in_user,only:[:index,:edit,:update,:following,:followers]
before_action :correct_user, only:[:edit,:update]

  protect_from_forgery
  #新規ユーザー
  def new
    @user = User.new
  end

  #全てのユーザー
  def index
    @users = User.paginate(page:params[:page])
  end

  #ユーザー表示画面
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  #新規登録
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "turistagramへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

   #プロフィール編集
   def update
    @user = User.find(params[:id])
     if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを編集しました！"
      redirect_to @user
     else
      render 'edit'
  end
end
  
  #ユーザーの情報をとる
  def edit
    @user = User.find(params[:id]) 
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users  = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users  = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  #登録の情報を受け取る
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end

 


  #正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

 
end

