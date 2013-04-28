class QuizzesController < ApplicationController

  def new
  	@user_id = current_user.id
  	@lesson = Lesson.find(params[:lesson_id])
    @question1 = Question.where(:lesson_id => params[:lesson_id]).shuffle[1]
    @question2 = Question.where(:lesson_id => params[:lesson_id]).shuffle[1]
    @question3 = Question.where(:lesson_id => params[:lesson_id]).shuffle[1]
    @question_answers = [['Root', 'Root'], ['Minor 2nd', 'Minor 2nd'], ['Major 2nd', 'Major 2nd'], ['Minor 3rd', 'Minor 3rd'], ['Major 3rd', 'Major 3rd'], ['Perfect 4th', 'Perfect 4th'], ['Augmented 4th', 'Augmented 4th'],['Perfect 5th', 'Perfect 5th'], ['Minor 6th', 'Minor 6th'], ['Major 6th', 'Major 6th'], ['Minor 7th', 'Minor 7th'], ['Major 7th', 'Major 7th']]
  end

  def create
    @question1_score = params[:user_answer1] == params[:correct_answer1] ? 1 : 0
    @question2_score = params[:user_answer2] == params[:correct_answer2] ? 1 : 0
    @question3_score = params[:user_answer3] == params[:correct_answer3] ? 1 : 0
    @score = @question1_score + @question2_score + @question3_score
    @lesson_id = params[:lesson_id]
    if @score == 3 
      flash[:notice] = "Unbelievable! You got #{@score} out of 3!"
      @quiz = Quiz.create!(:score => @score, :lesson_id => params[:lesson_id], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer1], :correct_answer => params[:correct_answer1], :lesson_id => params[:lesson_id], :octave => params[:octave1], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer2], :correct_answer => params[:correct_answer2], :lesson_id => params[:lesson_id], :octave => params[:octave2], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer3], :correct_answer => params[:correct_answer3], :lesson_id => params[:lesson_id], :octave => params[:octave3], :user_id => params[:user_id])
      render 'show'
    elsif @score == 2
      flash[:notice] = "Good work! You got #{@score} out of 3!"
      @quiz = Quiz.create!(:score => @score, :lesson_id => params[:lesson_id], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer1], :correct_answer => params[:correct_answer1], :lesson_id => params[:lesson_id], :octave => params[:octave1], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer2], :correct_answer => params[:correct_answer2], :lesson_id => params[:lesson_id], :octave => params[:octave2], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer3], :correct_answer => params[:correct_answer3], :lesson_id => params[:lesson_id], :octave => params[:octave3], :user_id => params[:user_id])
      render 'show'    
    elsif @score == 1
      flash[:notice] = "Hmmm.. you might need some more practice. You got #{@score} out of 3."
      @quiz = Quiz.create!(:score => @score, :lesson_id => params[:lesson_id], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer1], :correct_answer => params[:correct_answer1], :lesson_id => params[:lesson_id], :octave => params[:octave1], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer2], :correct_answer => params[:correct_answer2], :lesson_id => params[:lesson_id], :octave => params[:octave2], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer3], :correct_answer => params[:correct_answer3], :lesson_id => params[:lesson_id], :octave => params[:octave3], :user_id => params[:user_id])
      render 'show'
    else
      flash[:notice] = "Keep at it and you'll start to get it! You got #{@score} out of 3."
      @quiz = Quiz.create!(:score => @score, :lesson_id => params[:lesson_id], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer1], :correct_answer => params[:correct_answer1], :lesson_id => params[:lesson_id], :octave => params[:octave1], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer2], :correct_answer => params[:correct_answer2], :lesson_id => params[:lesson_id], :octave => params[:octave2], :user_id => params[:user_id])
      Response.create!(:user_answer => params[:user_answer3], :correct_answer => params[:correct_answer3], :lesson_id => params[:lesson_id], :octave => params[:octave3], :user_id => params[:user_id])
      render 'show'
    end
  end

  def show
  end

  def index
  end

end