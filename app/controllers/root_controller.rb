# frozen_string_literal: true

class RootController < ApplicationController
  def index
    redirect_to posts_path if is_logged_in?
  end
end
