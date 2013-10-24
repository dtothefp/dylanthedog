class VotesController < ApplicationController
  def new
    @random_dogs = Post.order("RANDOM()").limit(2).load
    render :new
  end

  def create
    post = Post.find(params[:post_id])
    post.votes += 1
    post.save
    redirect_to new_vote_path
  end
end