# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  # Like associations
  has_many :likes
  has_many :liked_by, through: :likes, source: :user

  has_many :comments

  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  def liked_by_user?(user)
    liked_by.include?(user)
  end
end
