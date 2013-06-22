class CreateLessonRatings < ActiveRecord::Migration
  def change
    create_table :lesson_ratings do |t|
      t.string :rating
      t.integer :user_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
