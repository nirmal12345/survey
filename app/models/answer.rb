class Answer < ActiveRecord::Base
  attr_accessible :description, :surveyname_id, :question_id, :user_id
  belongs_to :surveyname
  belongs_to :user
  belongs_to :question
  
  validates :description, :presence => true
  validates :description, :numericality => { :message => " should be a number" }, :if => :should_contain_only_numeric_value?

  def should_contain_only_numeric_value?
    return true if self.question.questiontype_id == 2
  end
  
end
