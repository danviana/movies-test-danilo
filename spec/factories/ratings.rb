FactoryBot.define do
  factory :rating do
    grade { Faker::Number.between(from: 0.1, to: 5.0).round(1) }

    trait :with_dependencies do
      movie { create(:movie) }
    end
  end
end
