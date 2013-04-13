class AnswersController < ApplicationController
  
  before_filter :require_normal_user, :only => ['create']
  
  #submit answers for survey
  def create
    @survey_answers = []
    @all_values = []
    @collect_values = []
      params[:answers].each do|answer_from_user|
        answer_from_user.each {|key,value|
          @all_values << value
          @survey_answers << Answer.new(:surveyname_id => params[:surveyname_id], :question_id => key.to_i, :description => value, :user_id => current_user.id)
          store_values = validate_all_the_questions(key,value)
          @collect_values << store_values if !store_values.nil?
        }
      end
      if @all_values.length == @collect_values.length
        Answer.transaction do
          @survey_answers.each(&:save)
        end
      end
      
    #save the response to survey from user
    if (!@collect_values.blank? && (@all_values.length == @collect_values.length))
      response = Response.new
      response.user_id = current_user.id
      response.surveyname_id = params[:surveyname_id]
      response.save
      redirect_to surveynames_path, :notice => "Successfully submitted. Thanks for responding!"
    else
      redirect_to :back, :notice => "Submittion Failed. Could be because of wrong inputs (or) blank inputs.
                                     Please re-enter values and submit again."
    end

  end
  
  #checks for appropriate value & blank fields on submitting survey answers
  def validate_all_the_questions(question_id, value)
    question_type = Question.find(question_id).questiontype_id
    if question_type == 2
      if value =~ /^[0-9]+$/ && !value.blank?
        return value
      end
    elsif question_type == 3
      if value =~ /^(3[01]|[12][0-9]|0[1-9])-(1[0-2]|0[1-9])-[0-9]{4}$/ && !value.blank?
          return value
      end
    else
      unless value.blank?
        return value
      end
    end
  end
end
