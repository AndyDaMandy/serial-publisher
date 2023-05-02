# frozen_string_literal: true

# User model, using devise
class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 25 }

  has_many :stories, dependent: :destroy
  has_many :chapters, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :followings
  has_many :followers, through: :followings
  has_many :inverse_followings, class_name: 'Following', foreign_key: 'follower_id'
  has_many :inverse_followers, through: :inverse_followings, source: :user

  enum role: %i[user moderator admin]
  after_initialize :set_default_role, if: :new_record?
  def set_default_role
    self.role ||= :user
  end

  scope :find_user, ->(username) { where('lower(username) ILIKE ?', '%' + username.downcase + '%')   }
end
