class NotesController < ApplicationController
	
	def create
		@note = current_user.submitted_notes.build(note_params)
		
    if @note.save
      respond_to do |format|
				owner = note_params[:notable_type].classify.constantize.find(note_params[:notable_id])
				@owner_notes = owner.notes
				
        format.html { redirect_to :back }
				format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:errors] = @note.errors.full_messages
          redirect_to :back
        end
				format.js 
      end
    end
		
	end
	
	def destroy # DELETE /notes/:id note_url(note)
    @note = Note.find(params[:id])
		owner_class = @note.notable_type.constantize
		owner = owner_class.find(@note.notable_id)
		
    @note.destroy
		# refresh
		@owner_notes = owner.notes

		respond_to do |format|
			format.html { redirect_to :back }
			format.js {}
		end
    
  end
	
	private
	
	def note_params
		params.require(:note).permit(:notable_type, :notable_id, :content)
	end
end
