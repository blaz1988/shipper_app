# frozen_string_literal: true

class SubmitBid::Action
  def initialize(carrier_name, route_id, load_type_id, price)
    @carrier_name = carrier_name
    @route_id = route_id
    @load_type_id = load_type_id
    @price = price
  end

  def call
    Bid.transaction do
      create_or_update_bid
      fetch_winning_bid
    end
    carrier.name
  end

  private

  attr_reader :carrier_name, :route_id, :load_type_id, :price

  def create_or_update_bid
    bid = Bid.find_or_initialize_by(carrier: carrier, route: route, load_type: load_type)
    bid.price = price
    bid.save!
  end

  def fetch_winning_bid
    Bid.where(route: route, load_type: load_type).order(:price).first
  end

  def carrier
    @carrier ||= Carrier.find_or_create_by(name: carrier_name)
  end

  def route
    @route ||= Route.find(route_id)
  end

  def load_type
    @load_type ||= LoadType.find(load_type_id)
  end
end
