class PointBibliography < ApplicationRecord
  belongs_to :point
  has_one_attached :image

  validates :ouvrage, presence: true
end
