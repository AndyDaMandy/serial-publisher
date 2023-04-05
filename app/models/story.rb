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
  validates :title, presence: true, length: {minimum: 1, maximum: 250 }
  validates :description, length: { minimum: 0, maximum: 1000 }
  validates :status, presence: true

  enum status: [:draft, :published, :archived]
end
