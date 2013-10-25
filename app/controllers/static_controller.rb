class StaticController < ApplicationController
    def index
    @random_post = Post.order("RANDOM()").limit(1).load
    render :index
  end
end