class ContentController < ApplicationController
  before_filter :authenticate_user!
  
  def silver
    authorize! :view, :silver, :message => 'Access limited to Silver Plan subscribers.'
    @lessons_et = Lesson.where(:category => "Ear Training") 
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