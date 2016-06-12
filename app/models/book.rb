class Book < ActiveRecord::Base
	has_many :bookings, dependent: :destroy
	mount_uploader :book_image, ImageUploader
	validates_processing_of :book_image
	validate :image_size_validation
	 
	private
	  def image_size_validation
	    errors[:book_image] << "should be less than 10000KB" if book_image.size > 10.0.megabytes
	  end

	def self.searchISBN(search)
		if search
			where(["book_isbn LIKE ?","%#{search}%"])
		end
	end
	def self.searchName(search)
		if search
			where(["book_title LIKE ?","%#{search}%"])
		end
	end
	def self.searchAuthor(search)
		if search
			where(["book_author LIKE ?","%#{search}%"])
		end
	end
	
end
