module Api
    module V1
        class PartnersController < Api::V1::BaseController
            skip_before_action :authenticate

            def index
                render json: { partners: ActiveModel::Serializer::CollectionSerializer.new(Partner.all, each_serializer: PartnerSerializer) }, status: 200
            end
        end
    end
end
