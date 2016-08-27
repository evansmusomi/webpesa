FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
    mobile { FFaker.numerify('+2547########') }
    name { FFaker::Name.name }
  end
end
