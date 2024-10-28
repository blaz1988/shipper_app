# frozen_string_literal: true

class FetchResults::EntryPoint
  def initialize(params:)
    @action = FetchResults::Action.new(params[:carrier_name])
  end

  def call
    action.call
  end

  private

  attr_reader :action
end
