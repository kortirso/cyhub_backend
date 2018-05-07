class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image_content
end
