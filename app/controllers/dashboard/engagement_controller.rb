class Dashboard::EngagementController < ApplicationController

  def index
    @engagements = Engagement.all
  end

end
