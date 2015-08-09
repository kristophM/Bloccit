require 'rails_helper'

 describe User do

   before do
     include TestFactories
     @user = authenticated_user
     @post = associated_post
   end

   describe "#favorited(post)" do
     it "returns `nil` if the user has not favorited the post" do
       expect(@user.favorited(@post)).to be_nil
     end

     it "returns the appropriate favorite if it exists" do
       @user.favorites.build(post: @post)
       expect(@user.favorited(@post)).to be_a Favorite
     end
   end
 end
