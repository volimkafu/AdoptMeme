class CaptionsController < ApplicationController
  def new
    @pet = Pet.find(params[:petid])
    render :new
  end
end
