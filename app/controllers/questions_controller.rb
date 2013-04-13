class QuestionsController < ApplicationController
  
  before_filter :require_admin_user, :except => ['take_survey']
  #list all the questions for the survey
  def index
    surveyname = Surveyname.find(params[:surveyname_id])
    @surveyquestions = surveyname.questions
  end
  
  def new
    @question = Question.new
  end
  
  #create new question for survey
  def create
    @question = Question.new(params[:question])
    @question.surveyname_id = params[:surveyname_id]
    @question.user_id = current_user.id
    if @question.save
      redirect_to surveyname_questions_path
    else
      render :new
    end
  end
  
  #edit the question for survey
  def edit
    @question = Question.find(params[:id])
  end
  
  #update the question for survey
  def update
    question = Question.find(params[:id])
    if question.update_attributes(params[:question])
      redirect_to surveyname_questions_path
    else
      render :edit
    end
  end
  
  #delte the question for survey
  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to surveyname_questions_path
  end
  
  #show survey questions for survey takers
  def take_survey
    if current_user
      surveyname = Surveyname.find(params[:surveyname_id])
      @surveyquestions = surveyname.questions
      @answer = Answer.new
    else
      flash[:notice] = 'You are not authorized to view this content, please login as Admin'
      redirect_to root_path      
    end
  end

end
