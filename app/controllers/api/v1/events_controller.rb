module Api
  module V1
    class EventsController < Api::V1::BaseController
      skip_before_action :authenticate

      def index
        render json: { events: ActiveModel::Serializer::CollectionSerializer.new(Event.all, each_serializer: EventSerializer) }, status: 200
      end
    end
  end
end
