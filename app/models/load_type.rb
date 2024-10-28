# frozen_string_literal: true

class LoadType < ApplicationRecord
  has_many :bids, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
