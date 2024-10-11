class Event < ApplicationRecord
  belongs_to :user
  validates :location, :start_time, :end_time, presence: true

  scope :chronological, -> { order(:start_time) }

  scope :today, -> { where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  def overlaps?(other_event)
    self.start_time < other_event.end_time && other_event.start_time < self.end_time
  end

  def lesser_end_time?
    self.start_time >= self.end_time
  end
end
