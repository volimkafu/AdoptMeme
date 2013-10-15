class UsersController < ApplicationController
  def index
    @users = User.all
    if params[:format] == "json" 
      render :json => @users
    else
      render :index
    end
  end
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.create(params[:user])
    if @user.save
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
