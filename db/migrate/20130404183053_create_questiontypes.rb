class CreateQuestiontypes < ActiveRecord::Migration
  def change
    create_table :questiontypes do |t|
      t.string :name
      t.timestamps
    end
  end
end
