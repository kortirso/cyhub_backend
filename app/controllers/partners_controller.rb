class PartnersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update destroy]
    before_action :authenticate_user!
    before_action :user_is_admin?
    before_action :find_partners, only: %i[index]
    before_action :find_partner, only: %i[edit update destroy]

    def index; end

    def new; end

    def create; end

    def edit; end

    def update
        @partner.update(partner_params)
        redirect_to partners_path
    end

    def destroy
        @partner.destroy
    end

    private

    def find_partners
        @partners = Partner.order(id: :asc)
    end

    def find_partner
        @partner = Partner.find_by(id: params[:id])
        render_not_found if @partner.nil?
    end

    def partner_params
        params.permit(:name, :label, :description, :link)
    end
end
