class TracksController < ApplicationController

  before_action :require_logged_in
	before_action :set_track, only: [:show, :edit, :update, :destroy]

  def new
    @track = Track.new
  end

  def show
		@owner = @track
		@owner_notes = @track.notes
  end

  # created within albums/show
  def create
    @album = Album.find_by(id: track_params[:album_id])
		@track = @album.tracks.build(track_params)
		
		respond_to do |format|
    	if @track.save
				format.js { render 'create', status: :created, location: @track, layout: !request.xhr? }
				#format.json { render json: @track }
				format.html { redirect_to track_url(@track) }
				#format.js { render :partial => 'tracks_table', :object => @track }
				
    	else
				format.js { render @track.errors, status: :unprocessable_entity }
				#format.json { render json: @track.errors.full_messages, status: :unprocessable_entity }
				format.html do
					flash[:errors] = @track.errors.full_messages
      		redirect_to album_url(@album)
				end
			end
    end
		
  end

  def edit
  end

  def update
  end

  def destroy
  end
	
	# NOTE: need to use params[:track_id], NOT [:id]!
	def destroy_note
    @note = Note.find(params[:id])
		@owner = Track.find(params[:track_id])
		@owner_id = @owner.id
		
    @note.destroy
		# refresh
		@destroy_url = "/albums/#{@owner.id}/notes/"
		@owner_notes = @owner.notes
		
		respond_to do |format|
			
			format.html { redirect_to :back }
			format.js
		end
    
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
