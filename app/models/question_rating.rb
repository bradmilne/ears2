class QuestionRating < ActiveRecord::Base
  attr_accessible :question_id, :rating, :user_id

  belongs_to :user
  belongs_to :question 
end
