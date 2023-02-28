FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    release_date { Faker::Date.between(from: '2000-01-01', to: Date.today) }
    runtime { Faker::Number.between(from: 90, to: 180) }
    genre { Faker::Number.between(from: 0, to: 12) }
    parental_rating { Faker::Number.between(from: 0, to: 4) }
    plot { Faker::Lorem.paragraph_by_chars(number: rand(200..500), supplemental: false) }

    trait :with_ratings do
      transient do
        quantity { 2 }
        grade { Faker::Number.between(from: 0.1, to: 5.0).round(1) }
      end

      after(:create) do |movie, evaluator|
        create_list(:rating, evaluator.quantity, movie: movie, grade: evaluator.grade)
      end
    end
  end
end
