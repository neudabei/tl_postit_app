class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
    # 1. set up instance variable for action
    # 2. redirect based on some condition

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    # post = Post.new(params[:post]) -> This would be normal, but instead we use a different method for strong parameters
    @post = Post.new(post_params)
    @post.creator = User.first # TODO: change once we have authentication (hard coded for now)

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end

  end

  def edit # => uses @post = Post.find(params[:id]) from set_post method
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to posts_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
