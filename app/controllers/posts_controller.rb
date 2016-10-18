class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # try to update this to sort by upvotes, not easy to do since the votable gem does not actually add votes to the post schema
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @comments = Comment.where(post_id: @post)
    @random_post = Post.where.not(id: @post).order("RANDOM()").first
  end

  def new
    # @post = Post.new
    @post = current_user.posts.build
  end

  def create
    #@post = Post.new(post_parameters)
    @post = current_user.posts.build(post_parameters)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_parameters)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_parameters
    params.require(:post).permit(:title, :link, :description, :image)
  end
end
