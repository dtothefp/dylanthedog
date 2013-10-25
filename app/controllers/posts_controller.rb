class PostsController < ApplicationController

#before_action :authenticated!, :authorized!, only: [:create]

  def index
    @posts = Post.all
      @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
        marker.lat post.latitude.to_f
        marker.lng post.longitude.to_f
        marker.picture({
                  :url => post.image.url(:thumb),
                  :width   => 60,
                  :height  => 60
          }) 
    end

  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    User.find_by(id: session[:user_id]).posts << post

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
      @message = "Your Image and GPS MetaData Uploaded Successfully"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

end


