class PostsController < ApplicationController
  def index
    @posts = Post.where.not(body: nil).where(parent_id: nil) # only listing standard posts
    render json: @posts
  end

  def following
    @posts = Post.by_user(current_user.following.map(&:followed_id))
    render json: @posts
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
