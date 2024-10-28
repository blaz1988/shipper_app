# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchResults::Action do
  let(:carrier) { create(:carrier, name: 'Test Carrier') }
  let(:carrier_2) { create(:carrier, name: 'Test Carrier 2') }
  let(:route) { create(:route, origin: 'Berlin', destination: 'Munich') }
  let(:load_type) { create(:load_type, name: '10 pallets') }

  let!(:winning_bid) { create(:bid, carrier: carrier, route: route, load_type: load_type, price: 100.0) }
  let!(:losing_bid) { create(:bid, carrier: carrier_2, route: route, load_type: load_type, price: 200.0) }

  describe '#call' do
    context 'when the carrier exists' do
      subject { described_class.new(carrier.name) }

      it 'returns bids for the carrier' do
        result = subject.call

        expect(result.size).to eq(1)
        expect(result.first[:route]).to eq("#{route.origin} -> #{route.destination}")
        expect(result.first[:load_type]).to eq(load_type.name)
        expect(result.first[:price]).to eq(winning_bid.price)
        expect(result.first[:winning]).to be true
      end
    end

    context 'when the carrier does not exist' do
      subject { described_class.new('NonExistentCarrier') }

      it 'raises a CarrierNotFound error' do
        expect { subject.call }.to raise_error(FetchResults::Errors::CarrierNotFound)
      end
    end

    context 'when the carrier has no bids' do
      let(:empty_carrier) { create(:carrier, name: 'Empty Carrier') }
      subject { described_class.new(empty_carrier.name) }

      it 'returns an empty array' do
        expect(subject.call).to eq([])
      end
    end
  end
end
