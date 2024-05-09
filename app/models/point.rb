class Point < ApplicationRecord

  has_many :roads
  has_many :sentiers, through: :roads

  validates :title, presence: true
  validates :infos, presence: true
  validates :lat, presence: true
  validates :long, presence: true

end
