class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :logs
  has_many :categories
end
