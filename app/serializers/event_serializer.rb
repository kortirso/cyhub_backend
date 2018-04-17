class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :link, :started_at, :finished_at, :image_content

  def started_at
    object.started_at.try(:strftime, '%Y/%m/%d %H:%M')
  end

  def finished_at
    object.finished_at.try(:strftime, '%Y/%m/%d %H:%M')
  end
end
