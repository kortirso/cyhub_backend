class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :description, :image_content
  has_one :member
end
