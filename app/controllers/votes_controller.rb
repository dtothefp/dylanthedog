class VotesController < ApplicationController
  def new
    @random_posts = Post.order("RANDOM()").where("user_id != #{User.find(session[:user_id]).id}").limit(2).load
    @user_voted_post_id = []
    User.find(session[:user_id]).voted_posts.each do |voted_post|
    @user_voted_post_id << voted_post.id
    end

    render :new
  end

  def create
    if !params[:post_id].nil?
      post = Post.find(params[:post_id])
      user = User.find(session[:user_id])
      user.voted_posts << post
    end
    
    redirect_to new_vote_path
  end
end

private 

def find_by_current_session
  find(session[:user_id])
end

# WHERE !Random numbers.include User.find(session[user_id].votes)