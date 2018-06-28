class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :item
  has_many :logs
end
