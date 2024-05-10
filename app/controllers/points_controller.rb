class PointsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @points = Point.all
  end

  def show
    @point = Point.find(params[:id])
  end

  def new
    @point = Point.new
  end

  def create
    @point = Point.new(point_params)
    @point.save
    redirect_to point_path(@point)
  end

  def edit
    @point = Point.find(params[:id])
  end

  def update
    @point = Point.find(params[:id])
    @point.update(point_params)
    redirect_to point_path(@point)
  end

  def destroy
    @point = Point.find(params[:id])
    @point.destroy
    redirect_to points_path, status: :see_other
  end

  private

  def point_params
    params.require(:point).permit(:title, :infos, :lat, :long, :video, :audio )
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end
end
