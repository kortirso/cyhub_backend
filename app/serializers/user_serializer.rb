class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username
  has_one :member
end
