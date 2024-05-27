class Decouverte < ApplicationRecord
    has_one_attached :circuit_acc_img
    has_one_attached :anim_scol_img

    has_rich_text :circuit_acc_text
    has_rich_text :anim_scol_text
end
