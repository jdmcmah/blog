class User < ActiveRecord::Base
    has_many :articles
    # Change email to lower case before saving.
    before_save { selfemail = email.downcase }
    
    # Validate that username has been input and that the username is unique.
    validates :username, presence: true, 
              uniqueness: {case_sensitive: false},
              length: {minimum: 3, maximum: 25}
    
    # REGEX for email format.
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    # Validate that email has been input, is unique and has a valid email format.
    validates :email, presence: true,
              uniqueness: {case_sensitive: false},
              length: {maximum: 105},
              format: { with: VALID_EMAIL_REGEX }
    
    has_secure_password
end
