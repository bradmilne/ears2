class Question < ActiveRecord::Base
  attr_accessible :answer, :lesson_id, :octave, :question, :audioclip_mp3, :audioclip_wav

  belongs_to :lesson
  has_many :responses

  has_attached_file :audioclip_mp3
  has_attached_file :audioclip_wav
end
