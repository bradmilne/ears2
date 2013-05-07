class LessonsController < ApplicationController
  def show
  	@lesson = Lesson.find(params[:id])
  	@questions = Question.where(:lesson_id => params[:id])
  	@questions.each do |question|
  	  answer = question[:answer]	
  	  if Response.where(:correct_answer => "{answer}") < 1
  	  	question[:average] = "No responses match"
  	  else
  	  	question[:average] = "Responses match"
  	  end
  	end

  	@response_answer = Response.where(:lesson_id => params[:id], :user_id => current_user.id).first
  	@question_answer = Question.where(:lesson_id => params[:id]).first
    @responsemaj3 = Response.where(:correct_answer => "Major 3rd").first
    @questionmaj3 = Question.where(:answer => @responsemaj3.correct_answer).first
    if @questionmaj3.answer == @responsemaj3.correct_answer
    	@correctness = "True"
    else
    	@correctness = "False"
    end
  end
end
