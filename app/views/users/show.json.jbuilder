json.id @user.id
json.username @user.username
json.full_name @user.full_name

json.updated_at @user.updated_at
json.created_at @user.created_at

json.post_count @user.posts.count
json.follower_count @user.followers.count
json.following_count @user.following.count

if @user.avatar.attached?
  json.avatar_path url_for(@user.avatar)
end
