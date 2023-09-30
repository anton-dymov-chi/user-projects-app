FactoryBot.define do
  factory :assignment do
    months { Faker::Number.between(from: 1, to: 12) }
    rnd_percentage { Faker::Number.between(from: 0.0, to: 100.0) }
    total { Faker::Number.decimal }

    association :assignmentable, factory: :employee
    project
  end
end
