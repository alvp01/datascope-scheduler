require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user_one) { create(:user) }
  let(:event) { create(:event, user: user_one) }

  it 'can be instantiated' do
    event = Event.new
    expect(event).to be_a(Event)
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(event).to be_valid
    end

    it 'is not valid without a start time' do
      event.start_time = nil
      expect(event).to_not be_valid
    end

    it 'is not valid without a end time' do
      event.end_time = nil
      expect(event).to_not be_valid
    end

    it 'is not valid without an user' do
      event.user = nil
      expect(event).to_not be_valid
    end

    it 'is not valid without a location' do
      event.location = nil
      expect(event).to_not be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:user).class_name('User') }
  end
end
