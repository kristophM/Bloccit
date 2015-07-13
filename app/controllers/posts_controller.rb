class PostsController < ApplicationController
  #put in skip filter
  #skip_before_action :flash_attack, :only => [:index, :new]

  def index
    @posts = policy_scope(Post)
    authorize @posts
  end

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @summary = @post.summary

    def markdown_title
      (render_as_markdown.render @post.title).html_safe
    end

    def markdown_body
      (render_as_markdown.render @post.body).html_safe
    end
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    authorize @post
  end

  def edit
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    # @post = Post.new(params.require(:post).permit(:title, :body))
    @topic = Topic.find(params[:topic_id])
    @post.topic = @topic
    authorize @post
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

private

def post_params
  params.require(:post).permit(:title, :body)
end

def render_as_markdown
  renderer = Redcarpet::Render::HTML.new
  extensions = {fenced_code_blocks: true}
  redcarpet = Redcarpet::Markdown.new(renderer, extensions)
end



end
