class TopicsController < ApplicationController
  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def show
    @topic = Topic.find(params[:id])
    authorize @topic
    @posts = @topic.posts.includes(:user).includes(:comments).paginate(page: params[:page], per_page: 10)

    def markdown_title
      renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
      (redcarpet.render @post.title).html_safe
    end

    def markdown_body
      renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
      (redcarpet.render @post.body).html_safe
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.destroy #Why don't we need to put params here?
      flash[:notice] = "Topic named \"#{@topic.name}\" has been deleted"
      redirect_to topics_path #Why is it that 'render :index' doesn't work here?
    else
      flash[:error] = "There was an error deleting the topic. Please try again."
      render :show
    end
  end

  def topic_params
    params.require(:topic).permit(:name, :description)
  end
end
