FactoryGirl.define do
  factory :transaction do
    amount { rand() * 1000 }
    happened_on { FFaker::Time.date }
    code { SecureRandom.hex(5) }
    transaction_type 0
    sender { :user }
    recipient { :user }
  end
end
