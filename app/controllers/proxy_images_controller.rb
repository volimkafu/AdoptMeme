class ProxyImagesController < ApplicationController
  # include Storable

  def show
    # begin
      @image = Image.find(params[:id])
      @blob = @image.get_aws_object
      send_data( @blob, { :type => 'image/jpg', :disposition => 'inline' } )
  end

end
