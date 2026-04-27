class Waypoint < ApplicationRecord
  belongs_to :sentier

  validates :lat, presence: true
  validates :lng, presence: true
  validates :position, presence: true
end


