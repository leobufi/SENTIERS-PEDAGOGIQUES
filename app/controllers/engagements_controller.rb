class EngagementsController < ApplicationController
  def new
    @engagement = Engagement.new
  end

  def create
    @engagement = Engagement.new(engagement_params)
    @engagement.save
    redirect_to dashboard_path
  end

  def edit
    @engagement = Engagement.find(params[:id])
  end

  def update
    @engagement = Engagement.find(params[:id])
    @engagement.update(engagement_params)
    redirect_to dashboard_path
  end

  def destroy
    @engagement = Engagement.find(params[:id])
    @engagement.destroy
    redirect_to dashboard_path, status: :see_other
  end

  private

  def engagement_params
    params.require(:engagement).permit(:sensib, :protec, :rules, :partner, :engagements_img )
  end
end
