class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :lesson_id
      t.string :question
      t.string :answer
      t.integer :octave

      t.timestamps
    end
  end
end
