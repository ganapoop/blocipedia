FactoryGirl.define do
  factory :wiki do
    title { Faker::Hipster.sentence }
    body { Faker::Hipster.paragraph }
    private false
    user
  end
end
