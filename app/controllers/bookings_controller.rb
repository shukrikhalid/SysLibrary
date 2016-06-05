class BookingsController < ApplicationController
  def index
  	@book = Book.find(params[:book_id])
    @booking = @book.bookings.all
  end
  def new
  	@book = Book.find(params[:book_id])
    @booking = @book.bookings.new
  end
  def create
    @book = Book.find(params[:book_id])
    #bookingN =  @book.bookings.new
   	#bookingN.booking_date_start = "#{booking_params[:booking_date_start]}"
   	#bookingN.booking_date_end =	"#{booking_params[:booking_date_start]}"
   	#bookingN.save
   	@booking = @book.bookings.create(booking_date_start: "#{booking_params[:booking_date_start]}" ,booking_date_end: "#{booking_params[:booking_date_start]}")
    	redirect_to book_bookings_path(@book)
  end
 
  def destroy
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