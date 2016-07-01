class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :own_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
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

  def own_post
    unless current_user == @post.user
      flash.now[:alert] = "Hey, that isn't your post bruh."
      redirect_to root_path
  end
end
