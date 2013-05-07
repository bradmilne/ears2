class LessonsController < ApplicationController
  def show
  	@lesson = Lesson.find(params[:id])
  	@questions = Question.where(:lesson_id => params[:id])
  	@questions.each do |question|
  	  total_answers = Response.where(:user_id => current_user.id, :question_id => question.id).count
  	  total_correct = Response.where(:user_id => current_user.id, :question_id => question.id, :result => "true").count
  	  question[:avg_score] = "#{total_correct}/#{total_answers}"
  	  #if Response.where(:user_id => current_user.id, :question_id => question.id).count < 1
        #question[:avg_score] = Response.where(:user_id => current_user.id, :question_id => question.id).count
      #else
      	#correct_answers = Response.where(:user_id => current_user.id, :question_id => question.id, :result => true).count
      	#total_answers    = Response.where(:user_id => current_user.id, :question_id => question.id).count
        #question[:avg_score] = (correct_answers/total_answers)*100.to_i
      #end
     end
  end
end
