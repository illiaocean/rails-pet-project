class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        format.html { redirect_to posts_path, flash: {success: 'Welcome back :)'}}
      else
        format.html { redirect_to signin_path, flash: {error: 'User not found. Please check your email and password.'}}
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    # todo: make sure it is displayed
    notice = 'You have successfully logged out.'
  end
end
