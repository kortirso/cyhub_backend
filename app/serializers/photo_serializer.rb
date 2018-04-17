class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :member_name, :description, :image_content

  def member_name
    object.member.try(:name)
  end
end
