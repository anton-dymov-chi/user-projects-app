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
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'update total apportionment' do
    let!(:employee) { create(:employee) }
    let!(:assignments) { create_list(:assignment, 10, total: 10, assignmentable: employee) }

    # It's needed because when we create assignments we recalculate employees total
    before { employee.update(total_apportionment: 10) }

    it 'set total_apportionment' do
      expect{ employee.update_total_apportionment }.to change(employee, :total_apportionment).from(10).to(100)
    end
  end
end
