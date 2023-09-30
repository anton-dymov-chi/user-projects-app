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

  describe 'validation tests' do
    let(:name) { 'Joe Doe' } 
    let(:employee) { build(:employee, name: name) }

    context "when name is valid" do
      it 'has valid name' do
        expect(employee).to be_valid
      end
    end
    
    context 'when name is not valid' do
      let(:name) { '12312rf' }

      it 'has invalid name' do
        expect(employee).to be_invalid
      end

      it 'throw an error' do
        employee.valid?
        expect(employee.errors.full_messages[0]).to eq('Name Must contain only letters and at least 3 letters and no more than 40 letters')  
      end
    end

    context 'when name is empty' do
      let(:name) { nil }
      
      it 'has empty name' do
        expect(employee).to be_invalid
      end
    end
  end
end
