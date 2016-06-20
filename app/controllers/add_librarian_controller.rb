class AddLibrarianController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  	@user = User.find(2)
  end

  def add
  	@user = User.find(2)
  	level = @user.user_level
  	if level.eql? "student"
  		@user.attributes = {user_level: "student librarian"}
  	else
  		@user.attributes = {user_level: "staff librarian"}
  	end
  	@user.save
  	render 'show'
  end

  def remove
  	@user = User.find(2)
  	level = @user.user_level
  	if level.eql? "student librarian"
  		@user.attributes = {user_level: "student"}
  	else
  		@user.attributes = {user_level: "staff"}
  	end
  	@user.save
  	render 'show'
  end

  def user_permit
  	params.require(:user).permit(:id,:user_ic, :user_name, :user_email, :password, :user_level, :user_address, :user_contact )
  end

end
