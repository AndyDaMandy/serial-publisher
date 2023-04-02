class Story < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  def should_generate_new_friendly_id?
    title_changed?
  end
  
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  validates :title, presence: true, length: {minimum: 1, maximum: 1000 }

  enum status: [:draft, :published, :archive]
end
