class EngagementsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @engagements = Engagement.all
  end

  def new
    @engagement = Engagement.new
  end

  def create
    @engagement = Engagement.new(engagement_params)
    if @engagement.save
      redirect_to dashboard_engagement_path
    else
      redirect_to dashboard_engagement_path, notice: "L'instance n'a pas pu être créée, réessayez ultérieurement ou contactez léo"
    end
  end

  def edit
    @engagement = Engagement.find(params[:id])
  end

  def update
    @engagement = Engagement.find(params[:id])
    if  @engagement.update(engagement_params)
      redirect_to dashboard_engagement_path
    else
      redirect_to dashboard_engagement_path, notice: "L'instance n'a pas pu être modifiée, réessayez ultérieurement ou contactez léo"
    end
  end

  def destroy
    @engagement = Engagement.find(params[:id])
    if @engagement.destroy
      redirect_to dashboard_engagement_path, status: :see_other
    else
      redirect_to dashboard_engagement_path, notice: "L'instance n'a pas pu être supprimée, réessayez ultérieurement ou contactez léo"
    end
  end

  private

  def engagement_params
    params.require(:engagement).permit(:sensib, :protec, :rules, :partner, :engagements_img )
  end


  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end
end
