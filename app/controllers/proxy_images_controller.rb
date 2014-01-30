class ProxyImagesController < ApplicationController

  def show
      @image = Image.find(params[:id])
      @blob = @image.get_aws_object
      send_data( @blob, { :type => 'image/jpg', :disposition => 'inline' } )
  end

end
