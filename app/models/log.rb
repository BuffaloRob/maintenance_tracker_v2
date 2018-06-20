class Log < ApplicationRecord
  belongs_to :item
  belongs_to :category
  validates :cost, numericality: true
  # validates :starts_after_today?, :due_before_start?
end
