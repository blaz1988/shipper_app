# frozen_string_literal: true

class Route < ApplicationRecord
  has_many :bids, dependent: :destroy

  validates :origin, presence: true
  validates :destination, presence: true

  def origin_to_destination
    "#{origin} -> #{destination}"
  end
end
