class Dashboard::SentiersController < ApplicationController

  def index
    @sentiers = Sentier.all
  end

end
