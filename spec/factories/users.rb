FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role 'standard'
    confirmed_at Time.now
  end
end
