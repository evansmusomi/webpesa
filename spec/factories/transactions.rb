FactoryGirl.define do
  factory :transaction do
    amount "9.99"
    happened_on "2016-06-27"
    code "MyString"
    sender_id 1
    recipient_id 1
  end
end
