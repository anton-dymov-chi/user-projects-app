FactoryBot.define do
  factory :assignment do
    months { Faker::Number.between(from: 1, to: 12) }
    rnd_percentage { Faker::Number.decimal }
    total { Faker::Number.decimal }

    association :assignmentable, factory: :employee
    project
  end
end
