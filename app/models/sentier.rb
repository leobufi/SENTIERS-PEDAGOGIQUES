class Sentier < ApplicationRecord
  has_one_attached :image

  has_many :roads, dependent: :destroy
  has_many :points, through: :roads

  has_rich_text :description

  accepts_nested_attributes_for :roads, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
  validates :color, presence: true
  validates :difficulty, presence: true
  validates :is_theme, presence: true, inclusion: [true, false], allow_blank: true
  validates :is_boucle, presence: true, inclusion: [true, false], allow_blank: true
  validates :starting_point_lat, presence: true
  validates :starting_point_long, presence: true
  validates :arrival_point_lat, presence: true
  validates :arrival_point_long, presence: true

end
