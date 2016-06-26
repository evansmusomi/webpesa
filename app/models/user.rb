class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  #Virtual attribute for authentication via mobile or email
  attr_accessor :login

  # Validations
  validates :mobile, presence:true, uniqueness:{ case_sensitive: false}, numericality: true, length:{ minimum: 10, maximum: 15}
  validates :name, presence: true 

  # Override Devise log in action behaviour to include use of mobile
  def self.find_for_database_authentication(warden_conditions)
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
  		where(conditions.to_hash).where(["mobile = :value OR lower(email) = :value", { :value => login.downcase }]).first
  	elsif conditions.has_key?(:mobile) || conditions.has_key(:email)
  		where(conditions.to_hash).first
  	elsif conditions[:email] && conditions[:email].downcase!
  		where(conditions.to_hash).first
  	end
  end
end
