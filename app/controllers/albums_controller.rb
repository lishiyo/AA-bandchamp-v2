class AlbumsController < ApplicationController

  respond_to :html, :js, :json

  before_action :require_logged_in
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def show
  end

  # only called from outside bands/:id
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_band
    @band = Band.find(params[:id])
  end

  def set_album
    @album = Album.find(params[:id])
  end

  # band_id passed as hidden input
  def album_params
    params.require(:album).permit(:band_id, :name, :album_type)
  end
end
