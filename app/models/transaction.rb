class Transaction < ActiveRecord::Base
  # Hooks
  before_create :generate_code!

  # Associations
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  # Basic Validations
  validates :happened_on, :sender_id, :recipient_id, presence: true
  validates :amount, numericality: { greater_than: 0 }, presence:true
  validates :code, presence: true, uniqueness:{ case_sensitive: false}, length: { is: 10 }
  validates :sender_id, :recipient_id, presence: true


  # Create unique transaction code
  def generate_code!
    
  end
end
