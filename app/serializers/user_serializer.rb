class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :days_left, :username
end
