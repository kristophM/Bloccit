class QuestionsController < ApplicationController
  
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params.require(:question).permit(:title,:body,:resolved))
    if @question.save
      flash[:notice] = "Question was saved."
      redirect_to @question
    else
      flash[:error] = "There was an error saving the question. Please try again."
      render :new
    end
  end


  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params.require(:question).permit(:title,:body,:resolved))
      flash[:notice] = "The question was successfully updated."
      redirect_to @question
    else
      flash[:error] = "The question could not be updated. Please try again."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:notice] = "This question was successfully deleted."
      render :index
    else
      flash[:error] = "The question could not be deleted. Please try again."
    end
  end



end
