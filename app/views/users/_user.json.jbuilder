# frozen_string_literal: true

json.extract! user, :id, :username, :full_name, :updated_at, :created_at

json.post_count user.posts.count
json.follower_count user.followers.count
json.following_count user.following.count

json.avatar_path url_for(user.avatar) if user.avatar.attached?
