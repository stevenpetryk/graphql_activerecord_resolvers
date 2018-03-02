require "factory_bot"

FactoryBot.define do
  factory :country do
    sequence(:name) { |n| "Country #{n}" }
  end

  factory :location do
    sequence(:name) { |n| "Location #{n}" }
  end

  factory :person do
    sequence(:name) { |n| "Country #{n}" }
  end

  factory :pet do
    sequence(:name) { |n| "Pet #{n}" }
  end
end
