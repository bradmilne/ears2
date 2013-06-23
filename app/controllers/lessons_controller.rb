class LessonsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
  	@lesson = Lesson.find(params[:id])
  	@questions = Question.where(:lesson_id => params[:id])
  	@questions.each do |question|
      if Response.where(:user_id => current_user.id, :correct_answer => question.answer).count < 1
        question[:rating] = "TBD"
      else
        if QuestionRating.where(:user_id => current_user.id, :question_id => question.id).first
          question_for_rating =  QuestionRating.where(:user_id => current_user.id, :question_id => question.id).first
          rating = question_for_rating.rating
          question[:rating] = rating
        else
          question[:rating] = "NO"
        end
      end
     #consider changing this so it's per response type, not question
  	  question[:total_answers] = Response.where(:user_id => current_user.id, :question_id => question.id).count
  	  question[:total_correct] = Response.where(:user_id => current_user.id, :question_id => question.id, :result => "true").count
     end
  end

  def index
  	@lessons_et = Lesson.where(:category => "Ear Training").order("id ASC")
      @lessons_et.each do |lesson|
        if Quiz.where(:user_id => current_user.id, :lesson_id => lesson.id).count < 1
          lesson[:rating] = "Not Started Yet"
        else
          if LessonRating.where(:user_id => current_user.id, :lesson_id => lesson.id).first
            lesson_for_rating =  LessonRating.where(:user_id => current_user.id, :lesson_id => lesson.id).first
            rating = lesson_for_rating.rating
            lesson[:rating] = rating
          else
            lesson[:rating] = "Needs Updating Still"
          end
        end
      end
    @highest_score = current_user.best_score_per_quiz
    @average_score = current_user.average_quiz_score
  end
end
