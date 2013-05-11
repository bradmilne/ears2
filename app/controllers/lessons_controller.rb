class LessonsController < ApplicationController
  def show
  	@lesson = Lesson.find(params[:id])
  	@questions = Question.where(:lesson_id => params[:id])
  	@questions.each do |question|
     #consider changing this so it's per response type, not question
  	  total_answers = Response.where(:user_id => current_user.id, :question_id => question.id).count
  	  total_correct = Response.where(:user_id => current_user.id, :question_id => question.id, :result => "true").count
  	  question[:avg_score] = "#{total_correct}/#{total_answers}"
     end
  end
end
