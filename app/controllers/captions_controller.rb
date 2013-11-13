class CaptionsController < ApplicationController
  def show
    redirect_to "/##{params[:captionid]}"
  end
end