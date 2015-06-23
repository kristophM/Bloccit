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
    # { :i_want_to_be_admin => true, :question => { title: "hi", body: "hello", resolved: true, is_admin: true } }
    # { title: "hi", body: "hello", resolved: true }
    if @question.update_attributes(params.require(:question).permit(:title,:body,:resolved))
      flash[:notice] = "The question was successfully updated."
      redirect_to @question # HTTP 302 Redirect, Location: /question/123
      # redirect_to question_path(@question, method: :get, action: :show) # /questions/123
      # redirect_to question_path(@question, method: :get, action: :edit) # /questions/123
    else
      flash[:error] = "The question could not be updated. Please try again."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:notice] = "This question was successfully deleted."
      
      # render :index #HTTP 200 . This would not give the data it needed v a redirect_to, which invokes the index action and loads the @questions instance variable. 
    else
      flash[:error] = "The question could not be deleted. Please try again."
    end
    redirect_to questions_path
  end



end
