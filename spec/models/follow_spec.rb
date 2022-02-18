require 'rails_helper'

RSpec.describe(Follow, type: :model) do
  describe 'validations' do
    it 'does not allow self follow' do
      a = User.create(username: 'abc')
      b = User.create(username: 'bcd')
      expect(Follow.new(follower: a, followed: b)).to be_valid
      expect(Follow.new(follower: a, followed: a)).not_to be_valid
    end
  end

  describe 'relationships' do
    it { should belong_to(:follower) }
    it { should belong_to(:followed) }
  end
end
