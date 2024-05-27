class Engagement < ApplicationRecord
    has_one_attached :engagements_img
    has_rich_text :sensib
    has_rich_text :protec
    has_rich_text :rules
    has_rich_text :partner
end
