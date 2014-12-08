class TracksController < ApplicationController

  before_action :require_logged_in
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  def new
    @track = Track.new
  end

  def show
  end

  # created within albums/new
  def create
    @album = Album.find_by(id: track_params[:album_id]) || Album.find_by(id: track_params[:id])
    @track = @album.tracks.build(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to album_url(@album)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_track
    Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:name, :length, :lyrics, :track_type, :album_id)
  end
end