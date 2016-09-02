FactoryGirl.define do
  factory :user, aliases: [:creator, :recipient] do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    title { Faker::Name.title }
    password 'abc-123'
    password_confirmation 'abc-123'
    confirmed_at { 3.days.ago }
    is_enabled true
  end
end
