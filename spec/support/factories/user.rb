# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test_#{i}@test.com" }
    password { '12345678' }
  end
end
