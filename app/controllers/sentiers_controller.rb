class SentiersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @sentiers = Sentier.all
    @general = General.first
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
    @sentier.save
    redirect_to sentier_path(@sentier)
  end

  def edit
    @sentier = Sentier.find(params[:id])
  end

  def update
    @sentier = Sentier.find(params[:id])
    @sentier.update(sentier_params)
    redirect_to sentier_path(@sentier)
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
