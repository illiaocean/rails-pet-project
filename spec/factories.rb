# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'jay' }
    full_name { 'Jay Nelson' }
    email { 'jnelson@gmail.com' }
    password { 'testing' }
  end

  factory :post do
    user_id { '1' }
    description { 'Lovely weather in Vancouver, BC' }
  end

  factory :comment do
    user_id { '2' }
    post_id { '1' }
    text { 'Love those grey colors!' }
  end

  factory :like do
    user_id { '2' }
    post_id { '1' }
  end

  factory :follow do
    follower_id { '1' }
    following_id { '2' }
  end
end
