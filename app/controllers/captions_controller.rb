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
    @caption = Caption.new(caption_params)
    @caption.captioner_id = self.current_user.id
    @caption.save
    redirect_to '/#{@caption.id}'
  end

  def show
    @caption = Caption.find(params[:captionid])
    render :show
  end

  private
    def caption_params
      params.require(:caption).permit(:top_text, :bottom_text, :image_id)
    end
end
