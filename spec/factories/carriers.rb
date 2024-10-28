# frozen_string_literal: true

FactoryBot.define do
  factory :carrier do
    name { "Carrier #{Faker::Company.unique.name}" }
  end
end
