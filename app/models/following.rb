# frozen_string_literal: true

# Following specific users
class Following < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: 'User'
end
