# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Route, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:bids).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:origin) }
    it { is_expected.to validate_presence_of(:destination) }
  end

  describe '#origin_to_destination' do
    it 'returns a string in the format origin -> destination' do
      route = described_class.new(origin: 'Berlin', destination: 'Warsaw')
      expect(route.origin_to_destination).to eq('Berlin -> Warsaw')
    end
  end
end
