FactoryBot.define do
 factory :product do
   association :user, factory: :user
   sequence(:title) { |n| "#{Faker::Commerce.product_name } - #{n}" }
   description { Faker::Lorem.paragraph }
   price { 11 + rand(1000) }
  end
end
