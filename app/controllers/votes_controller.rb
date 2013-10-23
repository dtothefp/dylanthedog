class VotesController < ApplicationController

  def index

    if session[:vote_id].nil?
      session[:vote_id] = []
    end

    if params[:id_1].nil? || params[:id_2].nil?
      @post = Post.all
      id_array = []
      while id_array.count < 2
       post_id = @post.sample.id
       if !id_array.include?(post_id) && !session[:vote_id].include?(post_id)
         id_array << post_id
       end
      end
      session.delete(:vote_id)
      id_1 = id_array[0]
      id_2 = id_array[1]
      #should leave values in array and check it the user has voted on the current id
      session[:vote_id] = id_array

      redirect_to "/votes/#{id_1}/#{id_2}"
    else

     render :index
    end
  end

  def show
    post = Post.find(params[:id])
    post.votes = post.votes + 1
    post.save

    redirect_to "/votes"
  end

  private


  
end