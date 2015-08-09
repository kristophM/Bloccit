class FavoritesController < ApplicationController
  def create
     post = Post.find(params[:post_id])
     favorite = current_user.favorites.build(post: post) #why is this not @favorite?
     authorize favorite
     if favorite.save
       flash[:notice] = "Favorite was saved."
       redirect_to [post.topic, post]
     else
       flash[:error] = "There was an error making a favorite. Please try again."
       render :new
     end
   end

   def destroy
     post = Post.find(params[:post_id])
     favorite = current_user.favorites.find(params[:id])
     authorize favorite
     if favorite.destroy
       flash[:notice] = "successfully unfavorited."
       redirect_to [post.topic, post]
     else
       flash[:error] = "Error, please try again"
       render :show
     end
   end
end
