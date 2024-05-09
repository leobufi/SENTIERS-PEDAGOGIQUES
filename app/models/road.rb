class Road < ApplicationRecord
  belongs_to :sentier
  belongs_to :point
end
