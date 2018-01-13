# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = 'supersecret'

Review.destroy_all
Product.destroy_all
User.destroy_all

super_user = User.create(
  first_name: 'Jon',
  last_name: 'Snow',
  email: 'js@winterfell.gov',
  password: PASSWORD,
  is_admin: true
)

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

puts Cowsay.say("Created #{users.count} users", :tux)

100.times do
  Product.create(
    title: Faker::Commerce.product_name,
    description: Faker::HitchhikersGuideToTheGalaxy.quote,
    price: Faker::Commerce.price,
    user: users.sample
  )
end

products = Product.all

puts Cowsay.say("Create #{products.count} products", :ghostbusters)


products.each do |product|
  rand(0..5).times.each do
    Review.create(
      body: Faker::Hobbit.quote,
      rating: rand(0..5),
      product: product,
      user: users.sample
    )
  end
end

['Arts', 'Sports', 'News', 'Cats', 'Cartoons', 'Lifestyle', 'Tech'].each do |tag_name|
  Tag.create(name: tag_name)
end

reviews = Review.all

puts Cowsay.say("Create #{reviews.count} reviews", :ghostbusters)

# puts "Login with #{super_user.email} and password of '#{PASSWORD}'!"
puts "Login as admin with #{super_user.email} and password of '#{PASSWORD}'!"
