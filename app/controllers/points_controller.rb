class PointsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def show
    @point = Point.find(params[:id])
    @point_coordinates = [@point.lat, @point.long]
  end

  def new
    @point = Point.new
  end

  def create
    @point = Point.new(point_params)
    if @point.save
      url = point_url(@point)
      qrcode = RQRCode::QRCode.new(url)
      svg = qrcode.as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 11,
        standalone: true,
        use_path: true
      )
      encoded_svg = HTMLEntities.new.encode(svg)
      @point.update(qr_code: encoded_svg)
      redirect_to point_path(@point)
    else
      redirect_to dashboard_points_path, notice: "L'instance n'a pas pu être créée, réessayez ultérieurement ou contactez léo"
    end
  end

  def download_qr_code
    @point = Point.find(params[:id])
    decoded_svg = HTMLEntities.new.decode(@point.qr_code)
    send_data(decoded_svg, filename: "#{@point.title}.qr_code.svg", type: "image/svg+xml")
  end

  def edit
    @point = Point.find(params[:id])
  end

  def update
    @point = Point.find(params[:id])
    if @point.update(point_params)
      redirect_to point_path(@point)
    else
      redirect_to dashboard_points_path, notice: "L'instance n'a pas pu être modifiée, réessayez ultérieurement ou contactez léo"
    end
  end

  def destroy
    @point = Point.find(params[:id])
    if @point.destroy
      redirect_to dashboard_points_path
    else
      redirect_to dashboard_points_path, notice: "L'instance n'a pas pu être créée, réessayez ultérieurement ou contactez léo"
    end
  end

  private

  def point_params
    params.require(:point).permit(
      :title,
      :infos,
      :lat,
      :long,
      :video,
      :audio,
      :image_1,
      :image_1_commment,
      :image_2,
      :image_2_commment,
      :image_3,
      :image_3_commment,
      :image_4,
      :image_4_commment,
      :image_5,
      :image_5_commment,
      :image_6,
      :image_6_commment,
      :image_7,
      :image_7_commment,
      :image_8,
      :image_8_commment,
      :image_9,
      :image_9_commment,
      :image_10,
      :image_10_commment
    )
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end
end
