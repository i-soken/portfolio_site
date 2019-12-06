class LikesController < ApplicationController
  before_action :logged_in_user 

  def create
    @post = Post.find(params[:post_id]) 
    unless @post.like?(current_user)
      @post.like(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url }
        format.js {render layout: false}
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.like?(current_user)
      @post.unlike(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js {render layout: false}
      end
    end
  end
end
