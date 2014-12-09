class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	helper_method :current_user, :logged_in?, :same_user?
  respond_to :html, :js

	# SESSIONS
	def current_user
		return nil if session[:session_token].nil?

		@current_user ||= User.find_by(session_token: session[:session_token])
	end

	def login!(user)
		# same as .send but returns nil rather than error
		# current_user ? current_user.reset_session_token : nil
		user.try(:reset_session_token!)
		# set @current_user to save first call
		@current_user = user
		session[:session_token] = user.session_token
	end

	def logout!
		current_user.try(:reset_session_token!)
		session[:session_token] = nil
	end

	def logged_in?
		!!current_user
	end

	def same_user?(user)
		current_user && user == current_user
	end

	def require_logged_in
		unless logged_in?
			redirect_to new_session_url
		end
	end


	# ATTACHABLE

	def load_dropzone_images
		@image = Image.new(attachment: image_params[:attachment])

    trans = Image.transaction do
      @image.save!
      attach_image(@image, params[:controller].classify, params[:id])
    end

		if trans
      respond_to do |format|
				format.json { render json: { message: "success", fileID: @image.id }, :status => 200 }
      end
		else
			format.json { render json: { error: @image.errors.full_messages }, :status => 400 }
    end

	end

	def attach_image(image, sub_type, sub_id)
		image.update!(attachable_type: sub_type, attachable_id: sub_id)

    image
	end


  # NOTABLE

  # add_note => POST /notes
  def add_note
    @note = current_user.submitted_notes.build(note_params)

    if @note.save
      respond_to do |format|
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

  # destroy_note_url => DELETE /notes/:id
  def destroy_note
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to :back
  end

  private

  def image_params
    params.require(:image).permit(:attachment, :attachable_type, :attachable_id)
  end

  def note_params # send in from form
    params.require(:note).permit(:content, :user_id, :notable_type, :notable_id)
  end

end
