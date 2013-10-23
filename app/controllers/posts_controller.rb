class PostsController < ApplicationController

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
    
      # if @post.image_content_type == "image/jpeg"
      #  gps_jpg = EXIFR::JPEG.new(@post.image).gps?  
      #   if gps_jpg
      #     @message = "JPG image has GPS Metadata"
      #   else
      #     @message = "No GPS Metadata for JPG"
      #   end
      # elsif @post.image_content_type == "image/png"
      #  gps_png = EXIFR::PNG.new(@post.image).gps?   
      #   if gps_png
      #       @message = "PNG image has GPS Metadata"
      #   else
      #      @message = "No GPS Metadata for PNG"
      #   end
      # end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

end


