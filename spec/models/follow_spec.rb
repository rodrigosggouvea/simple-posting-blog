require 'rails_helper'

RSpec.describe(Follow, type: :model) do
  describe 'validations' do
    let!(:a) { User.create(username: 'abc') }
    let!(:b) { User.create(username: 'bcd') }

    it 'does not allow self follow' do
      expect(Follow.new(follower: a, followed: b)).to be_valid
      expect(Follow.new(follower: a, followed: a)).not_to be_valid
    end

    it 'does not allow double follow' do
      Follow.create(follower: a, followed: b)
      expect(Follow.new(follower: a, followed: b)).not_to be_valid
    end
  end

  describe 'relationships' do
    it { should belong_to(:follower) }
    it { should belong_to(:followed) }
  end
end
