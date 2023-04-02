class Tag < ApplicationRecord
    #extend FriendlyId
    #friendly_id :name, use: :slugged
    #validates :name, presence: true, uniqueness: true
    has_many :taggables, dependent: :destroy
    has_many :stories, through: :taggables
end
