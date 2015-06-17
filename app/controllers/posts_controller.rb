class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
    # 1. set up instance variable for action
    # 2. redirect based on some condition
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    # post = Post.new(params[:post]) -> This would be normal, but instead we use a different method for strong parameters
    @post = Post.new(post_params)
    @post.creator = current_user

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
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    flash[:notice] = "Your vote was counted."
    redirect_to :back 
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
