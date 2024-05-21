class SentiersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @sentiers = Sentier.all
    @general = General.first
    # @coordinates = @sentiers.map do |sentier|
    #   coords = [
    #     { lat: sentier.starting_point_lat.to_f, lng: sentier.starting_point_long.to_f, type:'departure'},
    #     { lat: sentier.arrival_point_lat.to_f, lng: sentier.arrival_point_long.to_f, type: 'arrival' }
    #   ]
    #   coords += sentier.points.map do |point|
    #     { lat: point.lat, lng: point.long, type: 'point' }
    #   end
    # end
  end

  def themes
    @themes = Sentier.where(is_theme: true)
    @general = General.first
  end

  def show
    @sentier = Sentier.find(params[:id])
  end

  def new
    @sentier = Sentier.new
  end

  def create
    @sentier = Sentier.new(sentier_params)
    points_params = params[:sentier][:point_ids]
    points_params.delete("")
    points = Point.find(points_params)
    @sentier.points = points
    if @sentier.save
    redirect_to sentier_path(@sentier)
    else
      redirect_to new_sentier_path, notice: "Le Sentier n'a pas pu être créé, réessayez ultérieurement"
    end
  end

  def edit
    @sentier = Sentier.find(params[:id])
  end

  def update
    @sentier = Sentier.find(params[:id])
    points_params = params[:sentier][:point_ids]
    points_params.delete("")
    points = Point.find(points_params)
    @sentier.points = points
    if @sentier.update(sentier_params)
    redirect_to sentier_path(@sentier)
    else
      redirect_to edt_sentier_path(@sentier), notice: "Le Sentier n'a pas pu être modifier, réessayez ultérieurement"
    end
  end

  def destroy
    @sentier = Sentier.find(params[:id])
    @sentier.destroy
    redirect_to sentiers_path, status: :see_other
  end

  private

  def sentier_params
    params.require(:sentier).permit(:title, :description, :image, :duration, :difficulty, :is_theme, :starting_point_lat, :starting_point_long, :arrival_point_lat, :arrival_point_long )
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end

end
