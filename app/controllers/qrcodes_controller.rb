class QrcodesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :destroy]

  def new
    @qr_code = Qrcode.new
  end

  def create
    @qr_code = Qrcode.new(qr_code_params)
    if @qr_code.save
      redirect_to dashboard_qr_codes_path
    else
      redirect_to dashboard_qr_codes_path, notice: "L'instance n'a pas pu être créée, réessayez ultérieurement ou contactez léo"
    end
  end

  def download_qr_code
    @qr_code = Qrcode.find(params[:id])
    qrcode = RQRCode::QRCode.new(@qr_code.url)
    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
    send_data(svg, filename: "#{@qr_code.name}.qr_code.svg", type: "image/svg+xml")
  end

  def destroy
    @qr_code = Qrcode.find(params[:id])
    if @qr_code.destroy
      redirect_to dashboard_qr_codes_path
    else
      redirect_to dashboard_qrcodes_path, notice: "L'instance n'a pas pu être supprimée, réessayez ultérieurement ou contactez léo"
    end
  end

    private

  def qr_code_params
    params.require(:qrcode).permit(:name, :url )
  end

  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "Vous devez être administrateur pour effectuer cette action."
      redirect_to root_path
    end
  end
end
