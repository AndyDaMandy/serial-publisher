class Tag < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    has_many :taggables, dependent: :destroy
    has_many :stories, through: :taggables
end
