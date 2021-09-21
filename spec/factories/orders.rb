# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    status { :open }
    trait :closed do
      status { :closed }
    end
  end
end
