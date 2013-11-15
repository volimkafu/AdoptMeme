class PetsController < ApplicationController
  def index
    @pets = Pet.all
    render :index
  end

  def show
    begin
      @pet = Pet.find(params[:petid])
      render :show
    rescue
      redirect_to '/'
    end
  end
end
