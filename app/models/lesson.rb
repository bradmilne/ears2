class Lesson < ActiveRecord::Base
  attr_accessible :category, :description, :title

  has_many :questions
  has_many :quizzes
end
