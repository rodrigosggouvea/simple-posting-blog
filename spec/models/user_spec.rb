require 'rails_helper'

RSpec.describe(User) do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_length_of(username: { minimum: 3, maximum: 14 }) }
    it { should validate_uniqueness_of(:username) }

    it 'should validate username format' do
      expect(User.new(username: 'abc1')).to be_valid
      expect(User.new(username: 'abcç')).not_to be_valid
    end
  end

  describe 'relationships' do
    it { should have_many(:followers) }
    it { should have_many(:following) }
    it { should have_many(:posts) }
  end
end
