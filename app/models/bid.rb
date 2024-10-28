# frozen_string_literal: true

class Bid < ApplicationRecord
  belongs_to :carrier
  belongs_to :route
  belongs_to :load_type

  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :newest, -> { order(created_at: :desc) }

  scope :winning, ->(route, load_type) { where(route: route, load_type: load_type).order(:price).limit(1) }
end
  