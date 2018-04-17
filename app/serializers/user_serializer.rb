class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :member?
  has_one :member
end
