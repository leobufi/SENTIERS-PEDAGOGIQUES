class DecouvertesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @decouvertes = Decouverte.all
  end

  def new
    @decouverte = Decouverte.new
  end

  def create
    @decouverte = Decouverte.new(decouverte_params)
    if @decouverte.save(decouverte_params)
      redirect_to dashboard_decouvertes_path
    else
      render :new
    end
  end

  def edit
    @decouverte = Decouverte.find(params[:id])
  end

  def update
    @decouverte = Decouverte.find(params[:id])
    if @decouverte.update(decouverte_params)
      redirect_to dashboard_decouverte_path
    else
      flash[:alert] = "Échec de la modification."
      redirect_to root_path
    end
  end

  def destroy
    @decouverte = Decouverte.find(params[:id])
    @decouverte.destroy
    redirect_to dashboard_path
  end

  private

  def decouverte_params
    params.require(:decouverte).permit(:circuit_acc_text, :circuit_acc_img, :anim_scol_text, :anim_scol_img )
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end
end
