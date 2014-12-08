class BandsController < ApplicationController

	respond_to :html, :js

	before_action :set_band, except: [:index, :new, :create]
	before_action :require_logged_in

  def index
		@bands = Band.all
  end

  def show
		@bands = Band.all
		@album = Album.new
  end

  def new
		@band = Band.new
  end

  def create
		@bands = Band.all
		@band = current_user.submitted_bands.create(band_params)
		if @band.save
			respond_to do |format|
				# format.html { redirect_to band_url(@band)}
				format.js {}
			end
		else
			respond_to do |format|
				# format.html do
				# 	flash[:errors] = @band.errors.full_messages
				# 	redirect_to :back
				# end
				format.js { }
			end
		end
  end

  def edit
  end

  def update
		if @band.update(band_params)
			# flash[:success] = "Successfully updated."
			redirect_to band_url(@band)
		else
			flash[:errors] = @band.errors.full_messages
			redirect_to band_url(@band)
		end
  end

  def destroy
		@band.destroy
		redirect_to root_url
  end

	private

	def set_band
		@band = Band.find(params[:id])
	end

	def band_params
		params.require(:band).permit(:name, :description, :tagline, :date_created)
	end

end
