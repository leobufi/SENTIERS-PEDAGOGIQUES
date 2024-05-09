class DecouvertesController < ApplicationController
  def new
    @decouverte = Decouverte.new
  end

  def create
    @decouverte = Decouverte.new(decouverte_params)
    @decouverte.save
    redirect_to dashboard_path
  end

  def edit
    @decouverte = Decouverte.find(params[:id])
  end

  def update
    @decouverte = Decouverte.find(params[:id])
    @decouverte.update(decouverte_params)
    redirect_to dashboard_path
  end

  def destroy
    @decouverte = Decouverte.find(params[:id])
    @decouverte.destroy
    redirect_to dashboard_path, status: :see_other
  end

  private

  def decouverte_params
    params.require(:decouverte).permit(:circuit_acc_text, :circuit_acc_img, :anim_scol_text, :anim_scol_img )
  end
end
