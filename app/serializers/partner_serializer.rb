class PartnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :label, :description, :link, :logo_content
end
