class Story < ApplicationRecord
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :stars, dependent: :destroy
end
