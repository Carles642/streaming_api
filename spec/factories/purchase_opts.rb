FactoryBot.define do
  factory :product, class: 'PurchaseOpt' do
    price {12.99}
    quality {SD}
    trait :movie do
      association :product, factory: :movie
    end
    trait :season do
      association :product, factory: :season
    end
  end
end
