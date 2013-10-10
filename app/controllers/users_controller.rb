class UsersController < ApplicationController
  def index
    @users = User.all
    if params[:format] == "json" 
      render :json => @users
    else
      render :index
    end
  end
end
