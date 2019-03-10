class AuthorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @users = User.all
    @authors = User.includes(:posts)
  end

  def show
  end
end
