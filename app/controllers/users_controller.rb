class UsersController < ApplicationController
  def index
      @current_user = User.find session[:user_id]
      @users = User.all
      if (params[:searchStu].present?)
        @users = User.searchStu(params[:searchStu])
    end
    end
   
    def show
      @current_user = User.find session[:user_id]
      @user = User.find(params[:id])
    end
   
    def new
      @user = User.new
    end
   
    def edit
      @current_user = User.find session[:user_id]
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
        flash[:notice] = "Thanks you #{@user.user_name}. You have been sign up. Now you can login."
        flash[:color]= "valid"
        redirect_to sessions_login_path
      else
        render 'new'
      end
    end
   
    def update
      @user = User.find(params[:id])
   
      if @user.update(user_params)
        flash[:notice] = "Update successful"
        flash[:color]= "valid"
        redirect_to sessions_home_path
      else
        render 'edit'
      end
    end
   
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "Delete successful"
      flash[:color]= "valid"
      redirect_to users_path
    end
   
    private
      def user_params
        params.require(:user).permit(:user_ic, :user_name, :user_email, :password, :user_level, :user_address, :user_contact )
      end
end
