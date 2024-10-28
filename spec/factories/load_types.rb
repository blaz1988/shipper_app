# frozen_string_literal: true

FactoryBot.define do
  factory :load_type do
    name { "#{Faker::Number.between(from: 1, to: 26)} pallets" }
  end
end
