class PartnersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?
  before_action :find_partners, only: %i[index]
  before_action :find_partner, only: %i[edit update destroy]

  def index; end

  def new; end

  def create
    partner = Partner.new(partner_params)
    if partner.save
      redirect_to partners_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @partner.update(partner_params)
    redirect_to partners_path
  end

  def destroy
    @partner.destroy
  end

  private def find_partners
    @partners = Partner.order(id: :asc).with_attached_logo
  end

  private def find_partner
    @partner = Partner.find_by(id: params[:id])
    render_not_found if @partner.nil?
  end

  private def partner_params
    params.require(:partner).permit(:name, :label, :description, :link, :logo)
  end
end
