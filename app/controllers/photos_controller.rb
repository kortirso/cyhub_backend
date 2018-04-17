class PhotosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?
  before_action :find_photos, only: %i[index]
  before_action :find_photo, only: %i[destroy]

  def index; end

  def destroy
    @photo.destroy
    redirect_to photos_path, status: 303
  end

  private def find_photos
    @photos = Photo.order(id: :asc).with_attached_image
  end

  private def find_photo
    @photo = Photo.find_by(id: params[:id])
    render_not_found if @photo.nil?
  end
end
