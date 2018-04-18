module Api
  module V1
    class WelcomeController < Api::V1::BaseController
      skip_before_action :authenticate

      def index
        render json: {
          partners: ActiveModel::Serializer::CollectionSerializer.new(Partner.all, each_serializer: PartnerSerializer),
          members: ActiveModel::Serializer::CollectionSerializer.new(Member.active, each_serializer: MemberSerializer),
          events: ActiveModel::Serializer::CollectionSerializer.new(Event.all, each_serializer: EventSerializer),
          photos: ActiveModel::Serializer::CollectionSerializer.new(Photo.order(id: :asc).with_attached_image.limit(15), each_serializer: PhotoSerializer)
        }, status: 200
      end
    end
  end
end
