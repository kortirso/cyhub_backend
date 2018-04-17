class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :description, :link, :started_at, :finished_at, :link_to_file

  def started_at
    object.started_at.try(:strftime, '%Y/%m/%d %H:%M')
  end

  def finished_at
    object.finished_at.try(:strftime, '%Y/%m/%d %H:%M')
  end

  def link_to_file
    return nil unless object.image.attached?
    rails_blob_url(object.image, disposition: 'attachment', only_path: true)
  end
end
