# Description
This is an Instagram-like pet project I wrote to practice with Ruby and Ruby on Rails.

# Deployment
https://rails-social-playground.herokuapp.com/

# Main features
- Users
    - Sign up
    - Sign in
    - Edit and delete your profile
    - View profiles of other users
    - Follow / Unfollow other users
- Posts
    - Share
    - Edit and delete your posts
    - Like / Unlike
    - Comment
- Restful JSON API 
    
# Integrations
`ActiveStorage` is set up to store user uploaded assets in an AWS S3 bucket.

# Running locally
1. Have a postgres db running locally: `postgres -D /usr/local/var/postgres`.

2. Install dependencies and start up the server: `bundle && rails s`.

# Running unit tests
Run `rspec`.
