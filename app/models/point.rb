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

  has_rich_text :image_1_commment
  has_rich_text :image_2_commment
  has_rich_text :image_3_commment
  has_rich_text :image_4_commment
  has_rich_text :image_5_commment
  has_rich_text :image_6_commment
  has_rich_text :image_7_commment
  has_rich_text :image_8_commment
  has_rich_text :image_9_commment
  has_rich_text :image_10_commment

  validates :title, presence: true
  validates :infos, presence: true
  validates :lat, presence: true
  validates :long, presence: true

end
