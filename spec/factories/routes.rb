# frozen_string_literal: true

FactoryBot.define do
  factory :route do
    origin { Faker::Address.city }
    destination { Faker::Address.city }
  end
end
