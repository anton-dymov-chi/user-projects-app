# == Schema Information
#
# Table name: employees
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  salary              :float
#  total_apportionment :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    salary { Faker::Number.decimal }
    total_apportionment { Faker::Number.decimal }
  end
end
