class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      # todo: make this text red
      # todo: make sure it is displayed
      notice = 'User not found.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    # todo: make sure it is displayed
    notice = 'You have successfully logged out.'
  end
end
