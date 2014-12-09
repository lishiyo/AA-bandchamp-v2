class TracksController < ApplicationController

  before_action :require_logged_in
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  def new
    @track = Track.new
  end

  def show
  end

  # created within albums/show
  def create
    @album = Album.find_by(id: track_params[:album_id])

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
    @track = Track.includes(album: :band).find(params[:id])
    @notes = @track.notes
  end

  def track_params
    params.require(:track).permit(:name, :length, :lyrics, :track_type, :album_id)
  end
end
