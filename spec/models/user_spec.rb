require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: user.email)
      expect(user).to_not be_valid
    end
  end

  context 'associations' do
    it { should have_many(:events) }
  end
end
