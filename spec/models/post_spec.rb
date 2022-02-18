require 'rails_helper'

RSpec.describe(Post, type: :model) do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(body: { maximum: 777 }) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:parent) }
  end
end
