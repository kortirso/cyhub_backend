class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :description, :image_link
  has_one :member
end
