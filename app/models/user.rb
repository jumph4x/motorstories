class User
  include MongoMapper::Document
  attr_accessor :encrypted_password

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #,:trackable

  key :email, String
  key :name, String, :required => true

  timestamps!
end
