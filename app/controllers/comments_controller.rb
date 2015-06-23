class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
    
    if @comment.save
      flash[:notice] = "You have created your comment successfully."
    else
      flash[:error] = "You cannot post an empty comment."
    end
    redirect_to post_path(@post)
  end


  def comment_params
    params.require(:comment).permit(:body)
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You can only vote on a comment once."
        end
        redirect_to :back
      end
      format.js
    end
  end

end