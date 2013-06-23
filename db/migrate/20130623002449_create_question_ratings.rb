class CreateQuestionRatings < ActiveRecord::Migration
  def change
    create_table :question_ratings do |t|
      t.string :rating
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
