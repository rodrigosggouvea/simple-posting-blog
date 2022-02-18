class UsersController < ApplicationController
  before_action :set_user
  def show
    render json: {
      id: @user.id,
      username: @user.username,
      joined_at: I18n.l(@user.created_at.to_date, format: :long),
      followers: @user.followers.count,
      following: @user.following.count,
      posts: @user.posts.count
    }
  end

  def follow
    follow = current_user.following.build(followed: @user)
    if follow.valid?
      follow.save
      render json: follow
    else
      render json: { errors: follow.errors.messages }, status: :unprocessable_entity
    end
  end

  def unfollow
    current_user.following.where(followed: @user).first.destroy!
  end

  private

  def set_user
    @user = User.includes(:followers, :following).find(params[:id])
  end
end
