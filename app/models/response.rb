class Response < ActiveRecord::Base
  attr_accessible :correct_answer, :lesson_id, :octave, :result, :user_answer, :user_id, :question_id

  belongs_to :user
  belongs_to :lesson
  belongs_to :question

  before_create :answer_checker
  
  def answer_checker
    if self.correct_answer == self.user_answer
      self.result = "true"
    else
      self.result = "false"
      nil
    end
  end
end
