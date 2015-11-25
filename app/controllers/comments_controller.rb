class CommentsController < ApplicationController
  before_action :require_user

  def create
    byebug
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save 
      flash[:success]="Your comment was added"
      redirect_to post_path(@post)
    else
      flash[:notice]="Your comment was not added"
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote=Vote.create(user: current_user, vote: params[:like],
       votable: @comment)
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:success]="Thanks for your vote"
        else
          flash[:notice]="There was a problem with your vote"
        end
        redirect_to :back
      end

      format.js
    end

  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

end