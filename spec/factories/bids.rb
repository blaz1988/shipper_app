# frozen_string_literal: true

FactoryBot.define do
  factory :bid do
    price { Faker::Commerce.price(range: 50.0..1000.0) }
    association :carrier
    association :route
    association :load_type
  end
end
