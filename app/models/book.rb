class Book < ActiveRecord::Base
	has_many :bookings, dependent: :destroy
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
