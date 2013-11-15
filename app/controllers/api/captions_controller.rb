class Api::CaptionsController < ApplicationController
  def index
    @captions = Caption.all
    render :json => @captions, :include => :image_pet
  end

  def new
    @image = Image.find(params[:imageid])
    render :new
  end

  def create
    @caption = Caption.create(params[:caption])
    if @caption.save
      render :json => @caption
    else
      puts @caption.errors.full_messages
      render :json => @caption.errors.full_messages, :status => :bad_request
    end
  end

  def show
    @caption = Caption.find(params[:id])
    if !!@caption
      render :json => @caption
    else
      render :json => ["No caption found"], :status => :bad_request
    end
  end

end
