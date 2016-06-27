require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction){ FactoryGirl.build(:transaction) }
  subject { transaction }

  # Is valid factory
  it { should be_valid }

  # Responds to attributes
  it { should respond_to(:amount) }
  it { should respond_to(:happened_on) }
  it { should respond_to(:code) }
  it { should respond_to(:sender_id) }
  it { should respond_to(:recipient_id) }

  # Basic Validations
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should validate_presence_of(:happened_on) }
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:code).case_insensitive }
  it { should validate_length_of(:code).is_equal_to(10) }
  it { should validate_presence_of(:sender_id) }
  it { should validate_presence_of(:recipient_id) }
end
