class StatsController < ApplicationController

  def show
    @et_stats = current_user.ear_training_stats
    if current_user.has_role? :gold
      @cp_stats = current_user.chord_progression_stats
    else
      @cp_stats = nil
    end
  end

end
