class PostsController < ApplicationController
  def index

  end

  def show
   @post = Post.find(params[:some_name])
  end
end
