class AddLibrarianController < ApplicationController
  def index
    @current_user = User.find session[:user_id]
  	@users = User.all
  end

  def show
    @current_user = User.find session[:user_id]
  	@user = User.find(params[:format])
  end

  def add
    @current_user = User.find session[:user_id]
  	@user = User.find(params[:format])
  	level = @user.user_level
  	if level.eql? "student"
  		@user.attributes = {user_level: "student librarian"}
  	else
  		@user.attributes = {user_level: "staff librarian"}
  	end
    flash[:notice] = "#{@user.user_name}. Promote to librarian successful."
    flash[:color]= "valid"
  	@user.save
    redirect_to add_librarian_index_path
  end

  def remove
    @current_user = User.find session[:user_id]
  	@user = User.find(params[:format])
  	level = @user.user_level
  	if level.eql? "student librarian"
  		@user.attributes = {user_level: "student"}
  	else
  		@user.attributes = {user_level: "staff"}
  	end
    flash[:notice] = "#{@user.user_name}. Demote to librarian successful."
    flash[:color]=   "valid"
  	@user.save
    redirect_to add_librarian_index_path
  end

  def user_permit
  	params.require(:user).permit(:id,:user_ic, :user_name, :user_email, :password, :user_level, :user_address, :user_contact )
  end

end
