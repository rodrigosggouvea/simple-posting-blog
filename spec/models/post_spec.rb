require 'rails_helper'

RSpec.describe(Post, type: :model) do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(body: { maximum: 777 }) }

    it 'should deny more than 5 posts a day per user' do
      user = User.create(username: 'testuser')
      5.times { user.posts.create(body: 'tests post') }
      expect(user.posts.build(body: 'invalid post')).not_to be_valid
    end
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:parent) }
  end
end
