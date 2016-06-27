class Transaction < ActiveRecord::Base
  # Associations
  belongs_to :moneys_in, class_name: 'User'
  belongs_to :moneys_out, class_name: 'User'

  # Basic Validations
  validates :happened_on, :sender_id, :recipient_id, presence: true
  validates :amount, numericality: { greater_than: 0 }, presence:true
  validates :code, presence: true, uniqueness:{ case_sensitive: false}, length: { is: 10 }
  validates :sender_id, :recipient_id, presence: true
end
