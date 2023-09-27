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
class Employee < ApplicationRecord
    has_many :assignment
    has_many :project, throught: :assignment
end
