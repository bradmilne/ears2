class StatsController < ApplicationController

  def show
  	@user = current_user
  	@root = @user.ear_training_stats("Root")
  	@minor_2nd = @user.ear_training_stats("Minor 2nd")
  	@major_2nd = @user.ear_training_stats("Major 2nd")
  	@minor_3rd = @user.ear_training_stats("Minor 3rd")
  	@major_3rd = @user.ear_training_stats("Major 3rd")
  	@perfect_4th = @user.ear_training_stats("Perfect 4th")
  	@augmented_4th = @user.ear_training_stats("Augmented 4th")
  	@perfect_5th = @user.ear_training_stats("Perfect 5th")
  	@minor_6th = @user.ear_training_stats("Minor 6th")
  	@major_6th = @user.ear_training_stats("Major 6th")
  	@minor_7th = @user.ear_training_stats("Minor 7th")
  	@major_7th = @user.ear_training_stats("Major 7th")

    if current_user.has_role? :gold
      @cp_stats = @user.chord_progression_stats
    else
      @test = nil
    end
  end

end
