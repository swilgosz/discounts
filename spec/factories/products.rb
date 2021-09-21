# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    trait :green_tea do
      code { "GT1" }
      price  { "3.11" }
      name { "Green Tea" }
    end

    trait :strawberries do
      name { "Strawberies" }
      code { "SR1" }
      price { 5.00 }
    end

    trait :coffee do
      name { "Coffee" }
      code { "CF1" }
      price { 11.23 }
    end
  end
end
