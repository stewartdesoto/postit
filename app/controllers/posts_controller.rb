class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts= Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:success]='Your post was created'
      redirect_to @post
    else
      flash[:notice]="Problem creating post."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated"
      redirect_to post_path(@post)
    else
      flash[:notice] = "Post not updated"
      render 'edit'
    end
  end

  def vote
    puts "enter posts#vote"
    @vote = @post.votes.create(user: current_user, 
      vote: params[:like], votable: @post)
    puts "is vote valid #{ @vote.valid?}"
    respond_to do |format|
      format.js {}
      format.html do
        if @vote.valid?
          flash[:success] = "Thanks for your vote!"
          redirect_to :back
        else
          flash[:error] = "You can only vote once"
          redirect_to :back
        end
      end
    end
  end


  private
    def post_params
      params.require(:post).permit(:url, :title, 
        :description, :slug, category_ids: [])
    end

    def set_post
      @post = Post.find_by(slug: params[:id])
    end

    def vote_params
      params.require(:vote)
    end
end