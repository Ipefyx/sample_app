class UsersController < ApplicationController
	# force_ssl
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user,     only: :destroy
	
	def index
		# @users = User.all
		@users = User.paginate(page: params[:page])
	end
	
  def show
		@user = User.find(params[:id])
  end
  
  def new
		@user = User.new
  end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end
	
	def edit
		# @user = User.find(params[:id]) # Plus besoin de cette ligne care deja executée dans correct_user par before_filter
		# @user = User.find_by_remember_token(cookies[:remember_token]) # put current_user in a helper ?
		# @user = current_user # Apparement je peux utiliser les sessions_helpers aussi, surement grace à l'include dans l'application controler
		
		# Note: les 3 façons fonctionnent mais les deux derniers font echouer les tests... why ? D:
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated!"
			sign_in @user
			# render 'show' # Fonctionne aussi pour rediriger vers l'user
			redirect_to @user
		else 
			render 'edit'
		end
	end
	
	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
    redirect_to users_path
	end
	
	private
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_path, notice: "Please sign in."
			end
		end
		
		def correct_user
			@user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user 
			redirect_to(root_path) unless current_user.admin?
		end
end
