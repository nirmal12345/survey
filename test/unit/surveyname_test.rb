require 'test_helper'

class SurveynameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "invalid with empty attributes" do
    surveyname = Surveyname.new
    assert !surveyname.valid?
    assert surveyname.errors[:description].include?("can't be blank")
  end

end
