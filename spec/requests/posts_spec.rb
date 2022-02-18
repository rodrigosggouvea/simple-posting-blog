require 'rails_helper'

RSpec.describe('Posts', type: :request) do
  let!(:user) { User.create(username: 'testuser') }
  let(:headers) { { user_id: user.id } }

  describe 'GET /index' do
    it 'returns all posts' do
      5.times { |x| user.posts.create!(body: "Post ##{x}") }

      get '/posts', headers: headers

      ids = JSON.parse(response.body).map do |post|
        post['id']
      end

      expect(response).to have_http_status(:success)
      expect(ids.sort).to eq(Post.all.map(&:id).sort)
    end
  end

  describe 'GET /following' do
    it 'returns following users posts' do
      5.times { |x| user.posts.create!(body: "Post ##{x}") }
      other = User.create(username: 'other')
      Follow.create(follower: user, followed: other)
      other_post = other.posts.create!(body: 'other post')

      get '/posts/following', headers: headers

      ids = JSON.parse(response.body).map do |post|
        post['id']
      end

      expect(response).to have_http_status(:success)
      expect(ids).to include(other_post.id)
      expect(ids).not_to include(Post.first.id)
    end
  end

  describe 'POST /posts' do
    it 'returns errors with invalid post' do
      post '/posts', params: { post: { body: '' } }, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'creates a post successfully' do
      post '/posts', params: { post: { body: 'test post' } }, headers: headers

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['id']).to eq(Post.last.id)
    end
  end
end
