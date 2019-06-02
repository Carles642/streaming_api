FactoryBot.define do
  factory :product, class: 'PurchaseOpt' do
    price {12.99}
    quality {SD}
    association :product, factory: :movie
    trait :movie do
      association :product, factory: :movie
    end
    trait :season do
      association :product, factory: :season
    end
  end
end
