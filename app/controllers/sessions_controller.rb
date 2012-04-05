class SessionsController < ApplicationController
	# force_ssl

	def new
	end
	
	def create
		# user = User.find_by_email(params[:session][:email]) # With form_for
		# if user && user.authenticate(params[:session][:password])
		user = User.find_by_email(params[:email]) # With form_tag
		if user && user.authenticate(params[:password])
			sign_in user
			# redirect_to(session[:return_to || user])
			redirect_back_or user 
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end
	
	def destroy
		sign_out
		redirect_to root_path
	end
end
