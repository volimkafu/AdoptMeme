class CaptionsController < ApplicationController
  def show
    redirect_to "/##{params[:captionid]}"
  end

  def new
    redirect_to "/##{params[:captionid]}/new"
  end
end