class SummariesController < ApplicationController
  #no index method needed? 

  def new
    @summary = Summary.new 
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    authorize @topic
  end

  def edit
    @summary = Summary.find(params[:id])
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    authorize @topic
  end

  def update
    @summary = Summary.find(params[:id])
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    if @summary.update_attributes(params.require(:summary).permit(:body))
      flash[:notice] = "summary was updated."
      #redirect_to @summary 
      redirect_to topic_post_summary_path(@topic, @post, @summary)
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :edit
    end
  end

  def show
    @summary = Summary.find(params[:id])
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
  end

  def create
    @summary = Summary.new(params.require(:summary).permit(:body))
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    if @summary.save
      flash[:notice] = "Summary was saved."
      redirect_to topic_post_summary_path(@topic, @post, @summary)
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :new
    end
  end
end
