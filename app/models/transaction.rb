class Transaction < ActiveRecord::Base
  # Associations
  belongs_to :moneys_in, class_name: 'User'
  belongs_to :moneys_out, class_name: 'User'
end
