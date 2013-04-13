class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :description
      t.integer :questiontype_id
      t.integer :surveyname_id
      t.integer :user_id
      t.timestamps
    end
  end
end
