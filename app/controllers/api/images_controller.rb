class Api::ImagesController < ApplicationController
  def index
    @images = Image.limit(10).shuffle!
    render :json => @images, :include => :pet
  end
end
