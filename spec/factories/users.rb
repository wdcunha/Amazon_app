FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    # email "MyString"
    sequence(:email) {|n| Faker::Internet.email.sub('@', "-#{n}@")}
    password_digest "supersecret"
    is_admin false
  end

  trait :admin do
    is_admin true
  end
end
