class RoadsController < ApplicationController

  def destroy
    @road = Road.find(params[:id])
    @road.destroy
  end

  private

  def road_params
    params.require(:road).permit(:sentier_id, :point_id, :position)
  end

end
