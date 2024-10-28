# frozen_string_literal: true

class FetchResults::Action
  def initialize(carrier_name)
    @carrier_name = carrier_name
  end

  def call
    raise FetchResults::Errors::CarrierNotFound unless carrier.present?
      
    fetch_bids
  end

  private

  attr_reader :carrier_name

  def fetch_bids
    carrier.bids.includes(:route, :load_type).newest.map do |bid|
      {
        route: "#{bid.route.origin} -> #{bid.route.destination}",
        load_type: bid.load_type.name,
        price: bid.price,
        winning: winning_bid?(bid),
        route_id: bid.route.id,
        load_type_id: bid.load_type.id
      }
    end
  end

  def winning_bid?(bid)
    Bid.winning(bid.route, bid.load_type).first == bid
  end

  def carrier
    @carrier ||= Carrier.find_by(name: carrier_name)
  end
end
