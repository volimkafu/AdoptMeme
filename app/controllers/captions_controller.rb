class CaptionsController < ApplicationController
  def index
    @captions = Caption.all
    render :index
  end

  def new
    @image = Image.find(params[:imageid])
    render :new
  end

  def create
    @caption = Caption.create(params[:caption])
    @caption.save
    redirect_to "/#{@caption.id}"
  end

  def show
    @caption = Caption.find(params[:captionid])
    render :show
  end

end
