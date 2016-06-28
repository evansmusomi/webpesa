class Transaction < ActiveRecord::Base
  # Hooks
  before_validation :generate_code!, on: :create
  before_save :validate_amount

  # Virtual attribute for money transfer
  attr_accessor :recipient_key

  # Associations
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  # Custom transaction types
  enum transaction_type: { topup: 0, transfer: 1}

  # Basic Validations
  validates :code, uniqueness: { case_sensitive: false}, presence: true, length:{is: 10}
  validates :happened_on, :sender_id, :recipient_id, :transaction_type, presence: true
  validates :amount, numericality: { greater_than: 0 }, presence:true
  validates :sender_id, :recipient_id, presence: true

  # Create unique transaction code
  def generate_code!
    begin
      self.code = SecureRandom.hex(5)[0...10]
    end while self.class.exists?(code: code)
  end

  # Ensure the amount transferred is not more than what's in the account
  def validate_amount
    if transaction_type == :transfer
      if amount > User.find(sender_id).balance
        errors.add(:amount, "can't be more than your account balance")
      end
    end
  end
end
