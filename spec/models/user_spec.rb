require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ FactoryGirl.build(:user) }
  subject { user }

  # Is valid factory
  it { should be_valid }

  # Responds to attributes
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  # Validations
  
end
