FactoryGirl.define do
  factory :transaction do
    amount { rand() * 1000 }
    happened_on { FFaker::Time.date }
    code { SecureRandom.hex(5)[0...10] }
    transaction_type 0
    sender { FactoryGirl.create(:user) }
    recipient { FactoryGirl.create(:user) }
  end
end
