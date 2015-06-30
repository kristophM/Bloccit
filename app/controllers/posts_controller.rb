class PostsController < ApplicationController
  #put in skip filter
  #skip_before_action :flash_attack, :only => [:index, :new]

  def index
    @posts = policy_scope(Post)
    authorize @posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "post was updated."
      redirect_to @post 
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def create
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    # @post = Post.new(params.require(:post).permit(:title, :body))
    authorize @post
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end



end
