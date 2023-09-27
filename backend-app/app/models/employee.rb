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
  has_many :assignments, as: :assignmentable
  has_many :projects, through: :assignments

  def update_total_apportionment
    self.total_apportionment = assignments.sum(:total)
  end
end
