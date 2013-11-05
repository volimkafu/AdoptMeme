class PetsController < ApplicationController
  def index
    @pets = Pet.limit(10)
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
