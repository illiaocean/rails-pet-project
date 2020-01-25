# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    respond_to do |format|
      if user&.authenticate(params[:session][:password])
        session[:user_id] = user.id
        format.html { redirect_to posts_path, flash: { success: 'Welcome back 👋' } }
        format.json { render json: user }
      else
        format.html { redirect_to signin_path, flash: { error: 'User not found 👀 Please check your email and password.' } }
        format.json { render json: 'user not found', status: :unauthorized }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, flash: { success: 'Bye 👋' } }
      format.json { render json: 'logged out', status: :ok }
    end
  end
end
