class Point < ApplicationRecord

  has_many :roads, dependent: :destroy
  has_many :sentiers, through: :roads
  has_many :point_bibliographies, dependent: :destroy
  accepts_nested_attributes_for :point_bibliographies, allow_destroy: true, reject_if: :all_blank

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

  has_rich_text :bibliography
  has_many_attached :pdfs

  validates :title, presence: true
  validates :infos, presence: true
  validates :lat, presence: true
  validates :long, presence: true
  validate :pdfs_validation

  def to_param
    "#{id}-#{title.parameterize}"
  end

  private
  
  def pdfs_validation
    return unless pdfs.attached?

    pdfs.each do |pdf|
      if pdf.byte_size > 10.megabytes
        errors.add(:pdfs, "contient un fichier trop volumineux (max 10 MB)")
      end

      unless pdf.content_type == "application/pdf"
        errors.add(:pdfs, "contient un fichier qui n'est pas un PDF")
      end
    end
  end

end
