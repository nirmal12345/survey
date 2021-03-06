class User < ActiveRecord::Base
  attr_accessible :login,:email, :password, :password_confirmation, :name, :role_id
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_presence_of :name
  validates_presence_of :login
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  
  has_many :answers
  
  def self.authenticate(login, password)
    user = find_by_email(login) || find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end

