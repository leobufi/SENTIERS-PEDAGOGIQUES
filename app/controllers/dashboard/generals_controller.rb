class Dashboard::GeneralsController < ApplicationController

  def index
    @generals = General.all
  end

end
