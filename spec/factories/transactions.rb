FactoryGirl.define do
  factory :transaction do
    amount { rand() * 1000 }
    happened_on { FFaker::Time.date }
    code { SecureRandom.hex(5) }
    sender_id { rand() * 100 }
    recipient_id { rand() * 100 }
  end
end
