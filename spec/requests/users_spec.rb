require 'rails_helper'

RSpec.describe('Users', type: :request) do
  let!(:user) { User.create(username: 'testuser') }
  let(:headers) { { user_id: user.id } }
  describe 'GET /show' do
    it 'returns http success' do
      get "/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  context 'Follow requests' do
    let!(:followed) { User.create(username: 'anothertester') }
    describe 'POST /follow' do
      it 'returns http success' do
        post "/users/#{followed.id}/follow", headers: headers
        expect(response).to have_http_status(:success)
      end

      it 'raises error on self follow' do
        post "/users/#{user.id}/follow", headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'DELETE /unfollow' do
      it 'returns http success' do
        Follow.create(follower: user, followed: followed)
        delete "/users/#{followed.id}/unfollow", headers: headers
        expect(response).to have_http_status(:success)
      end
    end
  end
end
