class SentiersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @sentiers = Sentier.all
    @general = General.first
    @sentiers.each do |sentier|
      @roads = sentier.roads.sort_by(&:position)
      @points = @roads.map do |road|
          {
            lat: road.point.lat,
            lng: road.point.long,
            info_window_html: render_to_string(partial: "info_window", locals: {point: road.point})
          }
      end
    end
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
    @sentier.roads.build
  end

  def create
    @sentier = Sentier.new(sentier_params)
    if @sentier.save
    redirect_to sentier_path(@sentier)
    else
      redirect_to new_sentier_path, notice: "Le Sentier n'a pas pu être créé, réessayez ultérieurement ou contactez léo"
    end
  end

  def edit
    @sentier = Sentier.find(params[:id])
  end

  def update
    @sentier = Sentier.find(params[:id])
    if @sentier.update(sentier_params)
    redirect_to sentier_path(@sentier)
    else
      redirect_to edit_sentier_path(@sentier), notice: "Le Sentier n'a pas pu être modifier, réessayez ultérieurement ou contactez léo"
    end
  end

  def destroy
    @sentier = Sentier.find(params[:id])
    @sentier.destroy
    redirect_to sentiers_path, status: :see_other
  end

  private


  def sentier_params
    params.require(:sentier).permit(:title, :description, :color, :image, :duration, :difficulty, :is_theme, :starting_point_lat, :starting_point_long, :arrival_point_lat, :arrival_point_long, roads_attributes: [:id, :point_id, :position, :_destroy] )
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end

end
