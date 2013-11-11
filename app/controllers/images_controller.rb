class ImagesController < ApplicationController
  def index
    @images = Image.limit(10).shuffle
    render :index
  end
end
