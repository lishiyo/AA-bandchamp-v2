class UsersController < ApplicationController
	
	before_action :set_user, only: [:show, :edit, :update, :destroy, :load_image, :require_same_user]
	before_action :require_same_user, only: [:load_image]
	
	def index
		@users = User.all
	end
	
  def new
		@user = User.new
		@image = Image.new
  end

  def show
  end
	
	def create
		@user = User.new(user_params)
		
		if @user.save
			login!(@user)
			respond_to do |format|
				format.html do
					flash[:success] = "Successfully signed in."
					redirect_to user_url(@user)
				end
				format.json{ render :json => @user }
			end
			
		else
			flash.now[:errors] = @user.errors.full_messages
			render 'new'
		end
	end

  def edit
  end
	
	def update
		if @user.update(user_params)
			flash[:success] = "Updated profile."
			redirect_to user_url(@user)
		else
			flash.now[:errors] = @user.errors.full_messages
			render 'edit'
		end
	end
	
	def destroy
		@user.destroy
		redirect_to root_url
	end
	
	private
	
	def require_same_user
		# only current user allowed to upload images
		unless same_user?(@user)
			redirect_to :back, notice: "You are not authorized."
		end
	end

	def set_user
		@user = User.find(params[:id])
	end
	
	def user_params
		params.require(:user).permit(:email, :password)
	end
	
	
end
