class StatsController < ApplicationController

  def show
    @et_stats = current_user.ear_training_stats
    if current_user.has_role? :gold or current_user.has_role? :platinum or current_user.has_role? :admin
      @cp_stats = current_user.chord_progression_stats
    else
      @cp_stats = nil
    end
  end

end
