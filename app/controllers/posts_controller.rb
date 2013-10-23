class PostsController < ApplicationController

  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    #must add User.find(session[:user_id]).posts << post
    User.first.posts << post

    if post.save
      redirect_to post_path(post)
    else
      redirect_to new_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    
    if @post.latitude.nil? || @post.longitude.nil?
      @message = "Please find your location on the map"
    else
      @message = "Your coordinates uploaded Successfully"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

end


