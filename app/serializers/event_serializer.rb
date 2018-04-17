class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :link, :started_at, :finished_at
end
