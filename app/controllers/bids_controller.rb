# frozen_string_literal: true

class BidsController < ApplicationController
  def new
    @routes = Route.all.load_async
    @load_types = LoadType.all.load_async
  end

  def create
    redirect_to bids_path(carrier_name: SubmitBid::EntryPoint.new(params: params).call)
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash')
  end

  def index
    @bids = FetchResults::EntryPoint.new(params: params).call if params[:carrier_name]
  rescue FetchResults::Errors::CarrierNotFound => e
    flash.now[:alert] = e.message
  end
end
