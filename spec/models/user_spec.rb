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
  it { should validate_presence_of(:mobile) }
  it { should validate_numericality_of(:mobile) }
  it { should validate_uniqueness_of(:mobile).case_insensitive }
  it { should validate_presence_of(:name) }
  it { should have_many(:moneys_out) }
  it { should have_many(:moneys_in) }

  # Methods
  describe ".find_by_email_or_mobile" do
    let(:email){ FFaker::Internet.email }
    let(:mobile){ FFaker.numerify("+2547########") }
    let(:user){ FactoryGirl.create(:user, email: email, mobile: mobile) }

    it "returns user by mobile when mobile provided" do
      expect(User.find_by_email_or_mobile(user.mobile)).to eq user
    end

    it "returns user by email when email provided" do
      expect(User.find_by_email_or_mobile(user.email)).to eq user
    end
  end


end
