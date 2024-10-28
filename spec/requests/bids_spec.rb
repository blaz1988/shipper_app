# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bids', type: :request do
  let(:carrier_name) { 'Test Carrier' }
  let(:route) { create(:route) }
  let(:load_type) { create(:load_type) }
  let!(:carrier) { create(:carrier, name: carrier_name) }
  let(:valid_attributes) do
    {
      carrier_name: carrier_name,
      route_id: route.id,
      load_type_id: load_type.id,
      price: 100
    }
  end

  describe 'GET /new' do
    it 'returns http success and includes routes and load types' do
      get new_bid_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'redirects to the index page with carrier_name parameter and displays success message' do
        post bids_path, params: valid_attributes
        expect(response).to redirect_to(bids_path(carrier_name: carrier_name))
        follow_redirect!
        expect(response.body).to include('Your Bids')
      end
    end

    context 'with invalid attributes' do
      before { allow_any_instance_of(SubmitBid::EntryPoint).to receive(:call).and_raise(ActiveRecord::RecordInvalid) }

      it 'renders the flash alert via turbo stream' do
        post bids_path, params: valid_attributes
        expect(response.body).to include('flash')
      end
    end
  end

  describe 'GET /index' do
    context 'when carrier name is provided' do
      it 'returns http success and displays carrier bids' do
        get bids_path, params: { carrier_name: carrier_name }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when carrier does not exist' do
      it 'renders turbo stream with flash alert' do
        get bids_path, params: { carrier_name: 'NonExistentCarrier' }
        expect(response.body).to include('Carrier not found')
      end
    end

    context 'when no carrier name is provided' do
      it 'returns http success without displaying bids' do
        get bids_path
        expect(response).to have_http_status(:success)
        expect(response.body).not_to include('Your Bids')
      end
    end
  end
end
