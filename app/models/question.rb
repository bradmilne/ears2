class Question < ActiveRecord::Base
  attr_accessible :answer, :lesson_id, :octave, :question, :audioclip_mp3, :audioclip_wav

  belongs_to :lesson
  has_many :responses

  has_many :question_ratings

  has_attached_file :audioclip_mp3,
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['AWS_BUCKET'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
    
   
  has_attached_file :audioclip_wav,
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['AWS_BUCKET'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
end
