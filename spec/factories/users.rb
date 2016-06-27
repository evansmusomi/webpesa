FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
    mobile "0722000000"
    name { FFaker::Name.name }
  end
end
