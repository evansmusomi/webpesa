require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ FactoryGirl.build :user }
  subject { user }

  # Is valid factory
  it { should be_valid }

  # Responds to attributes
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:mobile) }
  it { should respond_to(:name) }

  # Basic Validations
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_presence_of(:mobile) }
  it { should validate_numericality_of(:mobile) }
  it { should validate_uniqueness_of(:mobile).case_insensitive }
  it { should validate_presence_of(:name) }
  it { should have_many(:moneys_out) }
  it { should have_many(:moneys_in) }

end
