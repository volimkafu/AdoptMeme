class ImagesController < ApplicationController
  def index
    @images = Image.all
    render :index
  end
end
