class Story < ApplicationRecord
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :stars, dependent: :destroy
  validates :title, presence: true, length: {minimum: 1, maximum: 1000 }
end
