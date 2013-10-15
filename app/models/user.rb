class User
  include MongoMapper::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  key :email,               String, :default => ""
  key :encrypted_password,  String, :default => ""
  
  ## Recoverable
  key :reset_password_token,    String
  key :reset_password_sent_at,  Time

  ## Rememberable
  key :remember_created_at, Time

  ## Trackable
  key :sign_in_count,       Integer, :default => 0
  key :current_sign_in_at,  Time
  key :last_sign_in_at,     Time
  key :current_sign_in_ip,  String
  key :last_sign_in_ip,     String

  ## Confirmable
  # key :confirmation_token,   String
  # key :confirmed_at,         Time
  # key :confirmation_sent_at, Time
  # key :unconfirmed_email,    String # Only if using reconfirmable

  ## Lockable
  # key :failed_attempts, Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # key :unlock_token,    String # Only if unlock strategy is :email or :both
  # key :locked_at,       Time

  ## Token authenticatable
  # key :authentication_token, String

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :name, :username

  attr_accessor :encrypted_password, :login

  has_many :vehicles, :dependent => :destroy

  key :name, String, :required => true
  key :username, String, :required => true, :unique => true
  key :location_id, Integer

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.where(:$or => [{:username =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }]).first
    else
      super
    end
  end

  timestamps!
end
