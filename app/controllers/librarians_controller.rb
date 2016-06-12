class LibrariansController < ApplicationController
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
    @booking = Booking.where(["user_id LIKE ? and status LIKE ?","#{@user.id}","booking"])

    @borrow = Booking.where(["user_id LIKE ? and status LIKE ?","#{@user.id}","borrow"])
  	
  	@return = Booking.where(["user_id LIKE ? and status LIKE ?","#{@user.id}","return"])

  end
  def borrow
  	@current_user = User.find session[:user_id]
  	@user = User.find(params[:format])
    booking = Booking.find_by(id: params[:booking_id],user_id: "#{@user.id}", status: "booking")
    current_date = Time.now.strftime("%Y-%m-%d") 
    if "#{booking.booking_date_start}".eql? current_date
		flash[:notice] = "Borrow Success."
		flash[:color]= "valid"
		if booking.update(status: "borrow")
		    redirect_to librarian_path(@user)
		else
		    render 'show'
		end
    else
		flash[:notice] = "Invalid. This booking for #{booking.booking_date_start}."
    	flash[:color]= "invalid"
		redirect_to librarian_path(@user)
    end
  end

  def return
  	@current_user = User.find session[:user_id]
  	@user = User.find(params[:format])
  	current_date = Time.now.strftime("%Y-%m-%d")
  	booking = Booking.find_by(id: params[:booking_id],user_id: "#{@user.id}", status: "borrow")
    sql = "SELECT datediff(curdate( ),'#{booking.booking_date_end}' ) AS DAY;"
    checkDate = ActiveRecord::Base.connection.select_value(sql)

    #current_date = Time.now.strftime("%Y-%m-%d")
    fineCheck = "#{checkDate}"
    if fineCheck.to_i > 0
    	total = 0.5*fineCheck.to_i
    	@fine = Fine.create(booking_id: "#{booking.id}", fines_amount: "#{total}",fines_status: "notpay" )
   		
   		flash[:notice] = "Return Success. Fines imposed"
    	flash[:color]= "invalid"
   	else
   		flash[:notice] = "Return Success."
		flash[:color]= "valid"
   	end
   		booking.update(status: "return", booking_date_return: "#{current_date}")
    
		redirect_to librarian_path(@user)
  end

  def pay
  	@current_user = User.find session[:user_id]
  	@user = User.find(params[:format])
  	current_date = Time.now.strftime("%Y-%m-%d")
  	
  	@fine = Fine.find_by(fines_status: "notpay", booking_id: params[:booking_id])
  	@fine.update(fines_date_pay: "#{current_date}",fines_status: "pay" )

    flash[:notice] = "Payment Success."
	flash[:color]= "valid"
   		

	redirect_to librarian_path(@user)
  end

end
