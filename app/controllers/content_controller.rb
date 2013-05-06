class ContentController < ApplicationController
  before_filter :authenticate_user!
  
  def silver
    authorize! :view, :silver, :message => 'Access limited to Silver Plan subscribers.'
    @lessons_et = Lesson.where(:category => "Ear Training") 
      @lessons_et.each do |lesson|
        if Quiz.where(:user_id => current_user.id, :lesson_id => lesson.id).count < 1
          lesson[:max_score] = 0
          lesson[:avg_score] = 0
        else
          lesson[:max_score] = ((Quiz.where(:user_id => current_user.id, :lesson_id => lesson.id).maximum(:score))/5*100).to_i
          lesson[:avg_score] = ((Quiz.where(:user_id => current_user.id, :lesson_id => lesson.id).average(:score))/5*100).to_i
        end
      end
    @highest_score = current_user.best_score_per_quiz
    @average_score = current_user.average_quiz_score
  end
  
  def gold
    authorize! :view, :gold, :message => 'Access limited to Gold Plan subscribers.'
    @lessons_et = Lesson.where(:category => "Ear Training") 
    @lessons_cp = Lesson.where(:category => "Chord Progressions") 
  end

  def platinum
    authorize! :view, :platinum, :message => 'Access limited to Platinum Plan subscribers.'
  end
end