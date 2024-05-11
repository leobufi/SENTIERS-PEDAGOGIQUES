class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @generals = General.all
  end

  def decouverte
    @decouverte = Decouverte.first
  end

  def engagements
    @engagement = Engagement.first
  end

end
