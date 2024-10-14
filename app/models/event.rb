class Event < ApplicationRecord
  belongs_to :user
  validates :location, :start_time, :end_time, presence: true

  scope :chronological, -> { order(:start_time) }

  scope :today, -> { where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
end
