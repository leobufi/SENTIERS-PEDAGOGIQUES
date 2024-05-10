class GeneralsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    @general = General.new
  end

  def create
    @general = General.new(general_params)
    @general.save
    redirect_to dashboard_path
  end

  def edit
    @general = General.find(params[:id])
  end

  def update
    @general = General.find(params[:id])
    @general.update(general_params)
    redirect_to dashboard_path
  end

  def destroy
    @general = General.find(params[:id])
    @general.destroy
    redirect_to dashboard_path, status: :see_other
  end

  private

  def general_params
    params.require(:general).permit(:general_pres, :home_img )
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end

end
