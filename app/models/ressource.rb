class Ressource < ApplicationRecord
  has_one_attached :image
  has_rich_text :content

  validates :image, presence: true
  validates :content, presence: true
  validate :single_instance_only, on: :create

  private

  def single_instance_only
    return unless Ressource.exists?

    errors.add(:base, "Une seule ressource peut être créée.")
  end
end
