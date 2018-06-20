class Category < ApplicationRecord
  belongs_to :item
  has_many :logs
  validates :name, presence: true
end
