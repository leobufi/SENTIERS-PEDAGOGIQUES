class Engagement < ApplicationRecord
    has_one_attached :engagements_img
    has_rich_text :sensib
    has_rich_text :protec
    has_rich_text :rules
    has_rich_text :partner

    validates :sensib, presence: true
    validates :protec, presence: true
    validates :rules, presence: true
    validates :partner, presence: true
    validates :engagements_img, presence: true

end
