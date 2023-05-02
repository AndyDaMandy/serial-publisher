# frozen_string_literal: true

# Star a story that you like
class Star < ApplicationRecord
  belongs_to :story
  belongs_to :user
end
