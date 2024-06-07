class GeneralsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    @general = General.new
  end

  def create
    @general = General.new(general_params)
    if @general.save
      redirect_to dashboard_generals_path
    else
      redirect_to dashboard_generals_path, notice: "L'instance n'a pas pu être créée, réessayez ultérieurement ou contactez léo"
    end
  end

  def edit
    @general = General.find(params[:id])
  end

  def update
    @general = General.find(params[:id])
    if @general.update(general_params)
      redirect_to dashboard_path
    else
      redirect_to dashboard_generals_path, notice: "L'instance n'a pas pu être modifiée, réessayez ultérieurement ou contactez léo"
    end
  end

  def destroy
    @general = General.find(params[:id])
    if @general.destroy
      redirect_to dashboard_path, status: :see_other
    else
      redirect_to dashboard_generals_path, notice: "L'instance n'a pas pu être supprimée, réessayez ultérieurement ou contactez léo"
    end
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
