# frozen_string_literal: true

# Bookmark model for stories
class Bookmark < ApplicationRecord
  belongs_to :story
  belongs_to :user
end
