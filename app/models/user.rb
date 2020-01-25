# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar

  has_many :posts

  # Like associations
  has_many :likes
  has_many :liked_posts, through: :likes, source: :posts

  # Follow associations
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  before_save { self.email = email.downcase }

  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  validates :full_name,
            presence: true,
            length: { maximum: 100 }

  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 3, maximum: 25 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 255 },
            format: { with: EMAIL_REGEX }

  validates :bio, length: { maximum: 1000 }

  has_secure_password

  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def followed_by?(user_id)
    follower_relationships.find_by(follower_id: user_id)
  end
end
