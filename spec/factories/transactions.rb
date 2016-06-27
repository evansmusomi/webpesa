FactoryGirl.define do
  factory :transaction do
    amount { rand() * 1000 }
    happened_on { FFaker::Time.date }
    code { SecureRandom.hex(5) }
    sender
    recipient
  end
end
