class Event < ApplicationRecord
  belongs_to :user
  validates :location, :start_time, :end_time, presence: true

  def overlaps?(other_event)
    self.start_time < other_event.end_time && other_event.start_time < self.end_time
  end
end
