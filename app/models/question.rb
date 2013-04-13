class Question < ActiveRecord::Base
   attr_accessible :description, :questiontype_id
   belongs_to :surveyname
   
   validates :description, :questiontype_id, :presence =>true
   
   #return the question type for the question
   def question_type_name(question)
     Questiontype.find(question.questiontype_id).name
   end
end
