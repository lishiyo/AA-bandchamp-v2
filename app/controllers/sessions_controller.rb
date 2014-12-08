class SessionsController < ApplicationController

  def new
		@user = User.new
  end

  def create
		@user = User.find_by_credentials(user_params)

		if @user
			login!(@user)
			flash[:success] = "Successfully signed in."
			redirect_to user_url(@user)
		else
			@user = User.new
			flash.now[:errors] = "Couldn't find user with those credentials."
			render :new
		end

  end

  def destroy
		logout!
		redirect_to root_url
  end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
