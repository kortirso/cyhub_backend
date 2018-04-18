module Api
  module V1
    class PhotosController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token, only: %i[create]
      skip_before_action :authenticate, only: %i[index]
      before_action :check_member, only: %i[create]

      def index
        render json: { photos: ActiveModel::Serializer::CollectionSerializer.new(Photo.order(id: :desc).with_attached_image.limit(15), each_serializer: PhotoSerializer) }, status: 200
      end

      def create
        photo = Photo.create(photo_params.merge(member: @user.member))
        photo.image.attach(io: File.open(params['photo']['image']), filename: "image.#{params['photo']['image'].split('.')[-1]}")
        render json: { photos: ActiveModel::Serializer::CollectionSerializer.new(Photo.order(id: :desc).with_attached_image.limit(15), each_serializer: PhotoSerializer) }, status: 200
      end

      private def check_member
        render json: { error: 'User does not have membership' }, status: 404 unless @user.member?
      end

      private def photo_params
        params.require(:photo).permit(:description)
      end
    end
  end
end
