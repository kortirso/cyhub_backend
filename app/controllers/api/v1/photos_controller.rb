module Api
  module V1
    class PhotosController < Api::V1::BaseController
      skip_before_action :authenticate

      def index
        render json: { photos: ActiveModel::Serializer::CollectionSerializer.new(Photo.order(id: :asc).with_attached_image.limit(15), each_serializer: PhotoSerializer) }, status: 200
      end
    end
  end
end
