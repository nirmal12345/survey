class Response < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :surveyname
  validates_uniqueness_of :surveyname_id, :scope => [:user_id]
end
