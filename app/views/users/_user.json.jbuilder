json.extract! user, :id, :username, :full_name, :updated_at, :created_at

json.post_count user.posts.count
json.follower_count user.followers.count
json.following_count user.following.count

if user.avatar.attached?
  json.avatar_path url_for(user.avatar)
end
