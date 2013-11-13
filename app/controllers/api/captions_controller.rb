class Api::CaptionsController < ApplicationController
  def index
    @captions = Caption.limit(20)
    render :json => @captions
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
      render :json => @caption.full_errors, :status => :bad_request
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
