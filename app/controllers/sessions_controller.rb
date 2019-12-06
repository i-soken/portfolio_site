class SessionsController < ApplicationController
  def new
  end

  #ログインの処理。downcaseを削除
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "ログインしました!"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています"
      render 'new'
  end
 end

 def destroy
    log_out if logged_in?
    redirect_to top_path
 end



end
