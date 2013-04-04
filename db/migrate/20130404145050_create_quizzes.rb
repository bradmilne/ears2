class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.decimal :score, :decimal, :precision => 5, :scale => 3
      t.integer :lesson_id
      t.integer :user_id

      t.timestamps
    end
  end
end
