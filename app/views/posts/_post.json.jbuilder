json.extract! post, :id, :description, :created_at, :updated_at

if post.image.attached?
  json.image_path url_for(post.image)
end

json.author do
  json.id post.user.id
  json.username post.user.username
  json.full_name post.user.full_name
end
