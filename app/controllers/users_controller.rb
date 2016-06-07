class UsersController < ApplicationController
  def index
      @users = User.all
    end
   
    def show
      @user = User.find(params[:id])
    end
   
    def new
      @user = User.new
    end
   
    def edit
      @user = User.find(params[:id])
    end
   
    def create
      @user = User.new(user_params)
      #user = User.new
      #user.user_ic = "#{user_params[:user_ic]}"
      #user.user_name = "#{user_params[:user_name]}"
      #user.user_email = "#{user_params[:user_email]}"
      #user.password = "#{user_params[:password]}"
      #user.user_address = "#{user_params[:user_address]}"
      #user.user_contact ="#{user_params[:user_phone]}"
      #user.user_level = "#{user_params[:user_level]}"
      #if user.save
   	  if @user.save
        #redirect_to users_path
        redirect_to sessions_login_path
      else
        render 'new'
      end
    end
   
    def update
      @user = User.find(params[:id])
   
      if @user.update(user_params)
        #redirect_to users_path
      else
        render 'edit'
      end
    end
   
    def destroy
      @user = User.find(params[:id])
      @user.destroy
   
      redirect_to users_path
    end
   
    private
      def user_params
        params.require(:user).permit(:user_ic, :user_name, :user_email, :password, :user_level, :user_address, :user_contact )
      end
end
