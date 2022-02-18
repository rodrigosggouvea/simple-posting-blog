# Strider Web Back-end Assessment - 2.1 - Rodrigo Gouvea - Ruby on Rails (back-end)

##POSTERR - an twitter-like application.

* Ruby version: 2.7.4

* Rails version: 7.0.1

* Database used: SQLite

* Tests framework: RSpec

* Debugging gem: Pry

### Seeds

* There is a seed file, to create and admin and an standard user

### Authentication

* Authentication is not required (fill take the first user as current user), but you cal also pass the user id on the user_id header

### Requests

* GET /users/:user_id
- User SHOW endpoint

* POST /users/:user_id/follow
- Request for following an user

* DELETE /users/:user_id/unfollow
- Request for unfollowing an user

* GET /posts
- Lists all posts

* GET /posts/following
- Lists all posts from current users following users

* POST /posts
- Parameters: body, and parent_id (id of parent post for quote/reply or repost)
- Creates post:
-- create a standard post by just sending body,
-- a repost by just sending the parent_id,
-- and a quote by sending both parent_id and body
