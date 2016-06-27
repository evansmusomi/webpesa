class Transaction < ActiveRecord::Base
  # Hooks
  before_create :generate_code!

  # Virtual attribute for money transfer
  attr_accessor :recipient_email, :recipient_mobile

  # Associations
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  # Custom transaction types
  enum type: { topup: 0, transfer: 1}

  # Basic Validations
  validates :happened_on, :sender_id, :recipient_id, :type, presence: true
  validates :amount, numericality: { greater_than: 0 }, presence:true
  validates :code, presence: true, uniqueness:{ case_sensitive: false}, length: { is: 10 }
  validates :sender_id, :recipient_id, presence: true

  # Create unique transaction code
  def generate_code!
    begin
      self.code = SecureRandom.hex(5)
    end while self.class.exists?(code: code)
  end
end
