class PostsController < ApplicationController
  before_action :set_post, only: [:show, :like, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show, :like]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def like
    user = get_current_user

    if @post.liked_by_user?(user)
      # Unlike the post if it is liked
      @post.liked_by = @post.liked_by - [user]
    else
      # Like the post if it is not liked yet
      @post.liked_by << user
    end

    redirect_to @post
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = get_current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      image = post_params[:image]
      @post.image.attach(image) if image
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:description, :image)
    end

    def require_same_user
      if get_current_user != @post.user
        notice = "You can only edit or delete your own posts."
        redirect_to posts_path
      end
    end
end
