class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :user_answer
      t.string :correct_answer
      t.string :result
      t.integer :octave
      t.integer :lesson_id
      t.integer :user_id

      t.timestamps
    end
  end
end
