module QuestionsHelper
  #collect all the question types to select while creating questions
  def questiontypes_for_select
    Questiontype.all.collect { |q| [q.name, q.id]}
  end
end
