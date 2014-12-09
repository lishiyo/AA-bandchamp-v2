class AlbumsController < ApplicationController

  respond_to :html, :js, :json

  before_action :require_logged_in
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def show
		@owner = @album
		@owner_notes = @album.notes
		@owner_id = @album.id
  end

	# only called from outside bands#show
  def new
    @album = Album.new
  end

	# create from bands#show
  def create
		# array of genre_ids (without empty strings)
    genre_ids = album_params[:genre_ids].delete_if(&:empty?).map(&:to_i)
		
		@band = Band.find(album_params[:band_id])
		@album = @band.albums.build(album_params.except(:band_id, :genre_ids))
		
		trans = Transaction do
			@album.save
			@album.attach_genre_taggings(genre_ids)
		end
		
		if trans.valid?
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
  end

  private


  def set_album
    @album = Album.includes(:band).includes(:tracks).find(params[:id])
    @notes = @album.notes
  end

  # band_id passed as hidden input
  def album_params
    params.require(:album).permit(:band_id, :name, :album_type, genre_ids: [])
  end
end
