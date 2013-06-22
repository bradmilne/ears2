class Lesson < ActiveRecord::Base
  attr_accessible :category, :description, :title

  has_many :questions
  has_many :quizzes
  has_many :responses
  has_many :lesson_ratings

  validates_presence_of :title

end
