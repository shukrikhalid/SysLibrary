class BookingsController < ApplicationController
  def index
    @current_user = User.find session[:user_id]
  	@book = Book.find(params[:book_id])
    @booking = @book.bookings.all
  end
  def new
    @current_user = User.find session[:user_id]
  	@book = Book.find(params[:book_id])
    @booking = @book.bookings.new
  end
  def create
    @current_user = User.find session[:user_id]
    @book = Book.find(params[:book_id])
    #bookingN =  @book.bookings.new
   	#bookingN.booking_date_start = "#{booking_params[:booking_date_start]}"
   	#bookingN.booking_date_end =	"#{booking_params[:booking_date_start]}"
   	#bookingN.save
   	@booking = @book.bookings.create(booking_date_start: "#{booking_params[:booking_date_start]}" ,booking_date_end: "#{booking_params[:booking_date_start]}", user_id: "#{@current_user.id}", status: "booking")
    	redirect_to book_bookings_path(@book)
  end
 
  def destroy
    @current_user = User.find session[:user_id]
    @book = Book.find(params[:book_id])
    @booking = @book.bookings.find(params[:id])
    @booking.destroy
    redirect_to book_path(@book)
  end
 
  private
    def booking_params
      params.require(:booking).permit(:booking_date_start, :booking_date_end)
    end
end