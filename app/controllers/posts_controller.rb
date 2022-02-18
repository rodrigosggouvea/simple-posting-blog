class PostsController < ApplicationController
  def index
    @posts = Post.where.not(body: nil).where(parent_id: nil) # only listing standard posts
    render json: @posts
  end

  def following
    @posts = Post.by_user(current_user.following.map(&:followed_id))
    render json: @posts
  end

  def replies
    @posts = current_user.posts.includes(replies: :user)
    response = @posts.map do |post|
      {
        id: post.id,
        body: post.body,
        added_at: I18n.l(post.created_at, format: :long),
        replies: post.replies.map do |reply|
          {
            id: reply.id,
            body: reply.body,
            added_at: I18n.l(reply.created_at, format: :long),
            user_id: reply.user_id,
            author: reply.user.username
          }
        end
      }
    end
    render json: response
  end

  def create
    # create a standard post by just sending body,
    # a repost by just sending the parent_id,
    # and a quote by sending both parent_id and body
    @post = current_user.posts.build(post_params)
    if @post.valid?
      @post.save
      render json: @post
    else
      render json: { errors: @post.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:parent_id, :body)
  end
end
