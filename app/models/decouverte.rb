class Decouverte < ApplicationRecord
    has_one_attached :circuit_acc_img
    has_one_attached :anim_scol_img

    has_rich_text :circuit_acc_text
    has_rich_text :anim_scol_text

    validates :circuit_acc_img, presence: true
    validates :circuit_acc_text, presence: true
    validates :anim_scol_img, presence: true
    validates :anim_scol_text, presence: true

end
