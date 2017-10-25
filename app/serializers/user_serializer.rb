class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :days_left
end
