# frozen_string_literal: true

json.extract! post, :id, :description, :created_at, :updated_at

json.image_path url_for(post.image) if post.image.attached?

json.author do
  json.extract! post.user, :id, :username, :full_name
end

json.comments post.comments do |comment|
  json.extract! comment, :id, :text, :created_at, :updated_at
end
