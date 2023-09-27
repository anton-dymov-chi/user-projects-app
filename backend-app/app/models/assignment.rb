# == Schema Information
#
# Table name: assignments
#
#  id             :bigint           not null, primary key
#  months         :integer          default(1), not null
#  rnd_percentage :float            default(0.0), not null
#  total          :float            default(0.0), not null
#  employee_id    :bigint
#  project_id     :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Assignment < ApplicationRecord
    before_update :update_total

    belongs_to :employee
    belongs_to :project

    def update_total
      if months_changed? || rnd_percentage_changed?
        self.total = (months * rnd_percentage) / 12
      end
    end
end
