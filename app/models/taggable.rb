# frozen_string_literal: true

# Join table between tags and stories
class Taggable < ApplicationRecord
  belongs_to :story
  belongs_to :tag
end
