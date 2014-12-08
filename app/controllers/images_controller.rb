class ImagesController < ApplicationController
	
	def create
	end
	
  def destroy
		@image = Image.find(params[:id])
    if @image.destroy    
      render json: { message: "File deleted from server" }
    else
      render json: { message: @image.errors.full_messages }
    end
  end
	
end
