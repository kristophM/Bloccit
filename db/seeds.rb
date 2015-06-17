require 'faker'

#Create posts
50.times do 
  Post.create!(
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

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

#Create advertisements
  Advertisement.create!(
    title: "First class tickets to Morrocco",
    copy: "Fly like you never have before",
    price: 500
    )

  Advertisement.create!(
    title: "Green leafy vegetables",
    copy: "Healthy and tasty, delivered to your home",
    price: 5
    )
