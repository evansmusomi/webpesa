class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authentication using mobile or email
  attr_accessor :login

  # Associations
  has_many :moneys_in, class_name: 'Transaction', foreign_key: 'recipient_id'
  has_many :moneys_out, class_name: 'Transaction', foreign_key: 'sender_id'

  # Basic Validations
  validates :mobile, presence:true, uniqueness:{ case_sensitive: false}, length:{ minimum: 10, maximum: 15}, numericality: true
  validates :name, presence: true

  # Overrides Devise log in action behaviour to include use of mobile, in addition to email.
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

  # Identifies user based on email address or mobile number provided.
  def self.find_by_email_or_mobile(key)
    # if number, search by mobile. Else search by email
    if key.to_i > 0
      User.find_by_mobile(key)
    else
      User.find_by_email(key)
    end
  end

  # Calculates user's account balance.
  def balance
    # Get difference between moneys_in and moneys_out
    balance = self.topups_sum(1) + self.money_received(1) - self.money_sent(1)
    if balance > 0
      balance.to_s
    else
      0
    end
  end

  # Gets user's top up transactions ordered by recency.
  def topups
    self.moneys_in.where(transaction_type: 0).order(id: :desc)
  end

  # Calculates the sum of top ups a user has made and gives the result as a numeber or string.
  def topups_sum(number = false)
    if number
      self.topups.sum(:amount)
    else
      self.topups.sum(:amount).to_s
    end
  end

  # Gets user's money transfer transactions ordered by recency.
  def sends
    self.moneys_out.where(transaction_type: 1).order(id: :desc)
  end

  # Calculates the sum of money transfers a user has made and gives the result as a number or string.
  def money_sent(number = false)
    if number
      self.sends.sum(:amount)
    else
      self.sends.sum(:amount).to_s
    end
  end

  # Gets user's money receipt transactions ordered by recency.
  def receipts
    self.moneys_in.where(transaction_type: 1).order(id: :desc)
  end

  # Calculates the sum of money a user has received and gives the result as a number or string.
  def money_received(number = false)
    if number
      self.receipts.sum(:amount)
    else
      self.receipts.sum(:amount).to_s
    end
  end
end
