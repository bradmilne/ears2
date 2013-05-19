class StatsController < ApplicationController

  def show
  	@user = current_user
  	@results_hash = @user.ear_training_stats_hash("Root")
  end

end
