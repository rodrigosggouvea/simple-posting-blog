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

## Planning - reply feature

### Questions
* The "Posts and Replies" route will list all posts, following posts or current user's posts? I'll assume the third option.

### Implementation
* On the database, reply posts are posts that have the body defined (the reply text), and parent_id defined (the main post reference). With that replies (on post model, a post have many replies based on parent_id) relationship, we can take each reply post and render the parent post alongside it on the controller.

### Tasks

* Add the replies relationship to Post model;

* Add the /replies GET route/action to PostsController, that retrieves all current user's posts, along with each post's replies, and map them accordingly with the following format:
  {
    id: main post id,
    body: main post body,
    added_at: main post creation datetime
    replies: [{
      id: reply_id,
      body: reply_body,
      added_at: reply creation datetime
      user_id: author user's id,
      author: author user's username
    }] 
  }

## Critique

* what I would like to improve:
** Implement unit tests for all scopes;
** Implement authentication using Devise gem;
** Implement pagination for all requests (using kaminari, or pagy gems);
** Implement serializers for Posts and Users, and remove that ugly code from the controllers;
** Improve search using elastic-search;
** Implement a GraphQL API for this application (using the graphql-ruby gem);
** Implement the front-end using ReactJS and GraphQL requests;

*about scaling:
  In my opinion performance-wise this bckend application is not really bad, 
  besides implementing pagination and the search improvements, 
  the only thing that would help scaling it would be creating a non-relational database for it

## Requests

* GET /users/:user_id
- User SHOW endpoint

* POST /users/:user_id/follow
- Request for following an user

* DELETE /users/:user_id/unfollow
- Request for unfollowing an user

* GET /posts
- Lists all posts

* GET /posts/search
- parameters: search
- Searches on all posts

* GET /posts/following
- Lists all posts from current users following users

* GET /posts/replies
- Lists all posts from current users with replies

* POST /posts
- Parameters: body, and parent_id (id of parent post for quote/reply or repost)
- Creates post:
-- create a standard post by just sending body,
-- a repost by just sending the parent_id,
-- and a quote by sending both parent_id and body
