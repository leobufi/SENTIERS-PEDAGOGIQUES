class Dashboard::RessourcesController < ApplicationController
  before_action :require_admin, only: [:index]

  def index
    @ressources = Ressource.all
  end

  private

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end
end
