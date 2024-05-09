class Dashboard::DecouverteController < ApplicationController
  def index
    @decouvertes = Decouverte.all
  end
end
