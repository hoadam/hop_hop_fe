FactoryBot.define do
  factory :user do
    name { Faker::Internet.user }
    email { Faker::Internet.email(name: name) }
    password { letmein }
    password_confirmation { letmein }
  end
end