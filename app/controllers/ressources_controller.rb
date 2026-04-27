class RessourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :show_current]
  before_action :require_admin, only: [:new, :create, :edit, :update]
  before_action :redirect_to_edit_if_exists, only: [:new, :create]
  before_action :set_ressource, only: [:show, :edit, :update]

  def show
  end

  def show_current
    @ressource = Ressource.first
    return redirect_to ressource_path(@ressource) if @ressource.present?

    redirect_to root_path, alert: "Aucune ressource n'est disponible pour le moment."
  end

  def new
    @ressource = Ressource.new
  end

  def create
    @ressource = Ressource.new(ressource_params)
    if @ressource.save
      redirect_to dashboard_ressources_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ressource.update(ressource_params)
      redirect_to dashboard_ressources_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ressource_params
    params.require(:ressource).permit(:image, :content)
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end

  def set_ressource
    @ressource = Ressource.find(params[:id])
  end

  def redirect_to_edit_if_exists
    return unless Ressource.exists?

    flash[:alert] = "Une seule ressource est autorisée. Modifiez la ressource existante."
    redirect_to edit_ressource_path(Ressource.first)
  end
end
