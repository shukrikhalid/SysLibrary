class SessionsController < ApplicationController
 
	before_filter :authenticate_user, :except => [:index, :login, :login_attempt, :logout]
	before_filter :save_login_state, :only => [:index, :login, :login_attempt]
	def show
	  @books = Book.all
      @user = @current_user.id
    end

	def home
		@books = Book.all
      	@current_user = User.find session[:user_id]
		#Home Page
	end

	def profile
		#Profile Page
	end

	def setting
		#Setting Page
	end

	def login
		#Login Form
	end

	def login_attempt
		authorized_user = User.authenticate(params[:user_email],params[:password])
		if authorized_user
			session[:user_id] = authorized_user.id
			@current_user = User.find session[:user_id]
			current_date = Time.now.strftime("%Y-%m-%d") 
			
			@bookingC = Booking.where(["booking_date_start < ? and status LIKE ?","#{current_date}","booking"])
			@bookingC.each do |b|
				b.update(status: "cancel")
			end
			out = "t"
			date = ""
			@bookingC = Booking.where(["status LIKE ?","cancel"])
			@bookingC.each do |b|
				if "#{b.user_id}".eql? "#{@current_user.id}" 
					out = "f"
					date = "#{b.booking_date_start}"
					b.destroy
				end
			end
			if "#{out}".eql? "f"	
				flash[:notice] = "Your booking at #{date} has been cancelled" 
				flash[:color]= "invalid"
			else 
				flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.user_name}"
				flash[:color]= "valid"
			end
			redirect_to(:action => 'home')


		else
			flash[:notice] = "Invalid Email or Password"
        	flash[:color]= "invalid"
			render "login"	
		end
	end

	def logout
		session[:user_id] = nil
		flash[:notice] = "You have been Log Out"
			flash[:color]= "valid"
		redirect_to :action => 'login'
	end
end
