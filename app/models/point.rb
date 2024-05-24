class Point < ApplicationRecord

  has_many :roads, dependent: :destroy
  has_many :sentiers, through: :roads

  has_one_attached :image_1
  has_one_attached :image_2
  has_one_attached :image_3
  has_one_attached :image_4
  has_one_attached :image_5
  has_one_attached :image_6
  has_one_attached :image_7
  has_one_attached :image_8
  has_one_attached :image_9
  has_one_attached :image_10

  validates :title, presence: true
  validates :infos, presence: true
  validates :lat, presence: true
  validates :long, presence: true

end
