class General < ApplicationRecord
  has_one_attached :home_img

  validates :general_pres, presence: true, uniqueness: true
  validates :home_img, presence: true, uniqueness: true
end
