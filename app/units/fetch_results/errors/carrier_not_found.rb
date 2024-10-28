# frozen_string_literal: true

class FetchResults::Errors::CarrierNotFound < StandardError
  def initialize(msg = 'Carrier not found.')
    super(msg)
  end
end
