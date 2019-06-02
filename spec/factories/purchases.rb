FactoryBot.define do
  factory :purchase do
    created_at {DateTime.now}
    user
    association :purchase_opt, factory: :product

    trait :movie do
      association :purchase_opt, factory: [:product, :movie]
    end

    trait :season do
      association :purchase_opt, factory: [:product, :season]
    end
  end
end
