class CaptionsController < ApplicationController
  def index
    @captions = Caption.all
    render :index
  end

  def new
    @pet = Pet.find(params[:petid])
    render :new
  end

  def create
    @caption = Caption.new(caption_params)
    @caption.captioner_id = self.current_user.id
    @caption.save
    redirect_to '/'
  end

  private
    def caption_params
      params.require(:caption).permit(:top_text, :bottom_text, :image_id)
    end
end
