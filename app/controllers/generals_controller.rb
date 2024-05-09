class GeneralsController < ApplicationController

  def new
    @general = General.new
  end

  def create
    @general = General.new(general_params)
    @general.save
    redirect_to dashboard_path
  end

  def edit
    @general = general.find(params[:id])
  end

  def update
    @general = general.find(params[:id])
    @general.update(general_params)
    redirect_to dashboard_path
  end

  def destroy
    @general = general.find(params[:id])
    @general.destroy
    redirect_to dashboard_path, status: :see_other
  end

  private

  def general_params
    params.require(:general).permit(:general_pres, :home_img )
  end

end
