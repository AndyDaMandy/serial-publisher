# frozen_string_literal: true

# Tag model for building tags
class Tag < ApplicationRecord
  # extend FriendlyId
  # friendly_id :name, use: :slugged
  # validates :name, presence: true, uniqueness: true
  has_many :taggables, dependent: :destroy
  has_many :stories, through: :taggables

  scope :find_name, ->(name) { where("lower(name) ILIKE ?", '%' + name + '%') }
end
