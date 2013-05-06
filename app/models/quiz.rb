class Quiz < ActiveRecord::Base
  attr_accessible :lesson_id, :score, :user_id

  belongs_to :user
  belongs_to :lesson

end
