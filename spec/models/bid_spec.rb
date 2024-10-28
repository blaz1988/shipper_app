# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bid, type: :model do
  let(:carrier) { create(:carrier) }
  let(:route) { create(:route) }
  let(:load_type) { create(:load_type) }
  let!(:bid1) { create(:bid, carrier: carrier, route: route, load_type: load_type, price: 100.0, created_at: 2.days.ago) }
  let!(:bid2) { create(:bid, carrier: carrier, route: route, load_type: load_type, price: 80.0, created_at: 1.day.ago) }

  describe 'associations' do
    it { is_expected.to belong_to(:carrier) }
    it { is_expected.to belong_to(:route) }
    it { is_expected.to belong_to(:load_type) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end

  describe '.newest' do
    it 'returns bids in descending order of creation' do
      expect(Bid.newest).to eq([bid2, bid1])
    end
  end

  describe '.winning' do
    it 'returns the bid with the lowest price for a specific route and load type' do
      winning_bid = Bid.winning(route, load_type).first
      expect(winning_bid).to eq(bid2)
      expect(winning_bid.price).to eq(80.0)
    end
  end
end
