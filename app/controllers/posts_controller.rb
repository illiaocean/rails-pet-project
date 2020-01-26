# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :require_user
  before_action :set_post, only: %i[show like add_new_comment edit update destroy]
  before_action :set_new_comment, only: [:show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    if params[:feed]
      current_user = get_current_user
      following = current_user.following
      posts = Post.all.select do |post|
        following_user = following.include? post.user
        post_user_id = post.user.id unless post.user.blank?
        same_user = post_user_id == current_user.id
        following_user || same_user
      end
    else
      posts = Post.all
    end

    @posts = posts.reverse
  end

  def show; end

  def like
    user = get_current_user
    message = ''

    if @post.liked_by_user?(user)
      # Unlike the post if it is liked
      @post.liked_by = @post.liked_by - [user]
      message = 'Unliked 👎'
    else
      # Like the post if it is not liked yet
      @post.liked_by << user
      message = 'Liked 👍'
    end

    respond_to do |format|
      format.html { redirect_to @post, flash: { success: message } }
      format.json { render json: message, status: :ok }
    end
  end

  def add_new_comment
    comment = Comment.new(new_comment_params)
    comment.user = get_current_user
    comment.post = @post

    respond_to do |format|
      if comment.save
        format.html { redirect_to @post, flash: { success: 'Comment added.' } }
        format.json { render :show, status: :ok }
      else
        format.html { render :show }
        format.json { render json: comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user = get_current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, flash: { success: 'Post created.' } }
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
        format.html { redirect_to @post, flash: { success: 'Post updated.' } }
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
      format.html { redirect_to posts_url, flash: { success: 'Post deleted' } }
      format.json { head :no_content }
    end
  end

  private

  def set_new_comment
    @new_comment = Comment.new
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:description, :image)
  end

  def new_comment_params
    params.require(:comment).permit(:text)
  end

  def require_same_user
    if get_current_user != @post.user
      notice = 'You can only edit or delete your own posts.'
      redirect_to posts_path
    end
  end
end
