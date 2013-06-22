class LessonRating < ActiveRecord::Base
  attr_accessible :lesson_id, :rating, :user_id

  belongs_to :user
  belongs_to :lesson 
  
end
