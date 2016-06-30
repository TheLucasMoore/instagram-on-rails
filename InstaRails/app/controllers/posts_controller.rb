class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    if @post = Post.create(post_params)
      flash[:succcess] = "Post Created!"
      redirect_to posts_path
    else 
      flash.now[:alert] = "Oh no. Something went wrong. Check your form again." 
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:succcess] = "Post Updated!"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "Oh no. Update Failure. Check your form again." 
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
