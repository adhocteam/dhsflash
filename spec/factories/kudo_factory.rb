FactoryGirl.define do
  factory :kudo do
    creator
    recipient
    message { Faker::Lorem.sentence(3) }
    category { Kudo::CATEGORIES.first }
  end
end
