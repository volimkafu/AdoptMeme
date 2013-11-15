class Api::ImagesController < ApplicationController
  def index
    @images = Image.all.shuffle!
    render :json => @images, :include => :pet
  end
end
