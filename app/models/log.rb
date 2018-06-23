class Log < ApplicationRecord
  belongs_to :item
  belongs_to :category
  validates :cost, numericality: true
  # validates :starts_after_today?, :due_before_start?

  def starts_after_today?
    if date_performed.present? && date_performed > Date.today 
      errors.add(:date_performed, "can't be in the future")
    end
  end

  def due_before_start?
    if date_due.present? && date_due < date_performed
      errors.add(:date_due, "can't be before the performed date")
    end
  end

  def category_blank?(att)
    att['name'].blank?
  end

  def self.past_due
    where("date_due <=?", Time.current)
  end

  def self.upcoming
    where("date_due <=?", Time.current + 30.days)
  end

end