# frozen_string_literal: true

class Carrier < ApplicationRecord
  has_many :bids, dependent: :destroy

  validates :name, presence: true
end
