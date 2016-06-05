class Booking < ActiveRecord::Base
	#validates :booking_date_start, presence: true, uniqueness: true
	validates :booking_date_start, :booking_date_end, overlap: { scope: 'book_id'}

	belongs_to :Book

end
# 
# 

