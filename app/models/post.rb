class Post < ApplicationRecord
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
end
