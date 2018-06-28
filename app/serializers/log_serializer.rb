class LogSerializer < ActiveModel::Serializer
  attributes :id, :notes, :tools, :cost, :date_performed, :date_due

  belongs_to :item
  belongs_to :category
end
