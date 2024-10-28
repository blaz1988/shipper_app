# frozen_string_literal: true

class SubmitBid::EntryPoint
  def initialize(params:)
    @carrier_name = params[:carrier_name]
    @load_type_id = params[:load_type_id]
    @route_id = params[:route_id]
    @price = params[:price]
  end

  def call
    SubmitBid::Action.new(carrier_name, route_id, load_type_id, price).call
  end

  private

  attr_reader :action, :carrier_name, :load_type_id, :route_id, :price
end
