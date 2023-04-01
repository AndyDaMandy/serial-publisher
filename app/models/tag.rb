class Tag < ApplicationRecord
    has_many :taggables, dependent: :destroy
    has_many :stories, through: :taggables
end
