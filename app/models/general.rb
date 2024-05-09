class General < ApplicationRecord
  validates :general_pres, presence: true, uniqueness: true
  validates :home_img, uniqueness: true
end
