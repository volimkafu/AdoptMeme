class Api::CaptionsController < ApplicationController
  def index
    @captions = Caption.limit(10)
    render :json => @captions, :include => :image_pet
  end

  def new
    @image = Image.find(params[:imageid])
    render :new
  end

  def create
    @caption = Caption.create(params[:caption])
    if @caption.save
      render :json => @caption, :include => :image_pet
    else
      puts @caption.errors.full_messages
      render :json => @caption.errors.full_messages, :status => :bad_request
    end
  end

  def update
    @caption = Caption.find(params[:id])
    @img_blob = decode_img_data(params[:imgData])
    @caption.create_aws_object(@img_blob)
    render :json => true # Ajax expects a JSON response.
  end

  def show
    @caption = Caption.find(params[:id])
    if !!@caption
      render :json => @caption, :include => :image_pet
    else
      render :json => ["No caption found"], :status => :bad_request
    end
  end

  require 'base64'

  private
    def decode_img_data(raw)
      body = raw[22..raw.length] # Strip out leading "data:image/png;base64,"
      Base64.decode64(body)
    end
end