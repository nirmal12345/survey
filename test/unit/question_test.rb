require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "invalid with empty attributes" do
    question = Question.new
    assert !question.valid?
    assert question.errors[:description].include?("can't be blank")
    assert question.errors[:questiontype_id].include?("can't be blank")
  end
end
