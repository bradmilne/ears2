class LessonsController < ApplicationController
  def show
  	@lesson = Lesson.find(params[:id])
  	@questions = Question.where(:lesson_id => params[:id])
  end
end
