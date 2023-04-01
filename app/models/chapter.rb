class Chapter < ApplicationRecord
  belongs_to :story
  belongs_to :user
  has_rich_text :content
  validates :title, presence: true, length: {minimum: 1, maximum: 1000 }
  validates :chapter_number, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }
end
