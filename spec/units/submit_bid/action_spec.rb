# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmitBid::Action, type: :model do
  let(:carrier_name) { 'Test Carrier' }
  let(:route) { create(:route) }
  let(:load_type) { create(:load_type) }
  let(:price) { 100.0 }
  let(:action) { described_class.new(carrier_name, route.id, load_type.id, price) }

  describe '#call' do
    context 'when the carrier and bid do not exist' do
      it 'creates a new bid for the carrier on the specified route and load type' do
        expect { action.call }.to change { Bid.count }.by(1)
        bid = Bid.last

        expect(bid.carrier.name).to eq(carrier_name)
        expect(bid.route).to eq(route)
        expect(bid.load_type).to eq(load_type)
        expect(bid.price).to eq(price)
      end
    end

    context 'when the bid exists' do
      let!(:carrier) { create(:carrier, name: carrier_name) }
      let!(:existing_bid) { create(:bid, carrier: carrier, route: route, load_type: load_type, price: 90.0) }

      it 'updates the bids price' do
        new_price = 110.0
        action_with_new_price = described_class.new(carrier_name, route.id, load_type.id, new_price)

        expect { action_with_new_price.call }.not_to change { Bid.count }
        expect(existing_bid.reload.price).to eq(new_price)
      end
    end

    context 'when determining the winning bid' do
      let!(:carrier) { create(:carrier, name: carrier_name) }
      let!(:bid1) { create(:bid, route: route, load_type: load_type, price: 80.0) }
      let!(:bid2) { create(:bid, route: route, load_type: load_type, price: 120.0) }

      it 'returns the correct winning bid' do
        action.call
        winning_bid = Bid.where(route: route, load_type: load_type).order(:price).first
        expect(winning_bid.price).to eq(80.0)
      end
    end

    context 'when saving a bid fails' do
      before do
        allow_any_instance_of(Bid).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'raises an error and does not create or update any bids' do
        expect { action.call }.to raise_error(ActiveRecord::RecordInvalid)
        expect(Bid.count).to eq(0)
      end
    end
  end
end
