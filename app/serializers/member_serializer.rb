class MemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :title, :description, :days_left, :avatar_link, :credit
end
