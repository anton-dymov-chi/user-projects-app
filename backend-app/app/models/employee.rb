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

  validates :name, 
            presence: true, 
            format: {
                      with: /[a-zA-Z\s?]{3,40}/, 
                      message: 'Must contain only letters and at least 3 letters and no more than 40 letters'
                    }

  def update_total_apportionment
    self.total_apportionment = assignments.sum(:total)
  end
end
