class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
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

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_parameters
    params.require(:post).permit(:title, :link, :description)
  end
end
