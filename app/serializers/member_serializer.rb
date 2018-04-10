class MemberSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :days_left
end
