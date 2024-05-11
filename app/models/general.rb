class General < ApplicationRecord
  has_one_attached :home_img

  validates :general_pres, presence: true, uniqueness: true
end
