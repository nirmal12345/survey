class Surveyname < ActiveRecord::Base
  attr_accessible :description
  has_many :questions, :dependent => :destroy
  has_many :responses, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  
  validates_presence_of :description
  def survey_response_count(surveyname_id)
    Response.count(:conditions => "surveyname_id = #{surveyname_id}")
  end
end
