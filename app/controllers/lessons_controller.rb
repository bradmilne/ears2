class LessonsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
  	@lesson = Lesson.find(params[:id])
  	@questions = Question.where(:lesson_id => params[:id])
  	@questions.each do |question|
     #consider changing this so it's per response type, not question
  	  question[:total_answers] = Response.where(:user_id => current_user.id, :question_id => question.id).count
  	  question[:total_correct] = Response.where(:user_id => current_user.id, :question_id => question.id, :result => "true").count
     end
  end

  def index
  	@lessons_et = Lesson.where(:category => "Ear Training").order("id ASC")
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
end
