class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :user_id,  presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
end
