require 'faker'

# for creating fake users
5.times do
  user = User.new(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# #Create posts
50.times do
  Post.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
    )
end

posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: Faker::Lorem.paragraph
    )
end

# puts "Seed finished"
# puts "#{Post.count} posts created"
# puts "#{Comment.count} comments created"

# #Create advertisements
#   Advertisement.create!(
#     title: "First class tickets to Morrocco",
#     copy: "Fly like you never have before",
#     price: 500
#     )

#   Advertisement.create!(
#     title: "Green leafy vegetables",
#     copy: "Healthy and tasty, delivered to your home",
#     price: 5
#     )

# for Questions
# 5.times do
#   Question.create!(
#     title: Faker::Lorem.sentence,
#     body: Faker::Lorem.paragraph
#     )
# end

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
        email: 'krist.m@gmail.com',
        password: 'helloworld'
)

puts "Seed finished."
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"




