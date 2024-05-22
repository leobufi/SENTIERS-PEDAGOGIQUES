class Road < ApplicationRecord
  belongs_to :sentier
  belongs_to :point

  validates :position, presence: true
end
