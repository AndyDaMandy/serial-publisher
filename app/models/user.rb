class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 25 }

    has_many :stories, dependent: :destroy
    has_many :chapters, dependent: :destroy
end
