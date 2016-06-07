class LevelValidator < ActiveModel::Validator
  def validate(record)
    if options[:fields].any?{|field| record.send(field) == "Select user type" }
      record.errors[:base] << "Select user type"
    end
  end
end
class User < ActiveRecord::Base

	has_many :bookings
	has_secure_password

	validates_with LevelValidator, fields: [:user_level]
	EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	#validates :user_name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  	validates :user_email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  	validates :password, :confirmation => true
  	
  	#validates :password_confirmation, :presence => true
  	#Only on Create so other actions like update password attribute can be nil
  	validates_length_of :password, :in => 6..20, :on => :create

    def self.authenticate(user_email="", password="")
      if  EMAIL_REGEX.match(user_email)    
        user = User.find_by_user_email(user_email)
      end

      if user && user.authenticate(password)
        return user
      else
        return false
      end
    end

    def match_password(password="")
      password_digest == BCrypt::Engine.hash_secret(password)
    end
  

end
