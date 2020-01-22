json.array! @posts do |post|
  json.created_at post.created_at
  json.updated_at post.updated_at
  json.description post.description

  if post.image.attached?
    json.image_path url_for(post.image)
  end

  json.like_count post.likes.count
  json.comment_count post.comments.count

  json.author do
    json.id post.user.id
    json.username post.user.username
    json.full_name post.user.full_name
  end
end
