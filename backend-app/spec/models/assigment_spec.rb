require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'set total before updating assignment' do
    let!(:assignment) { create(:assignment, months: 1, rnd_percentage: 10.0) }
    let(:initial_value) { assignment.total }

    context 'when update months' do
      let(:expected_value) { 1.6666666666666667 }

      it 'updates total' do
        expect { assignment.update(months: 2) }.to change{ assignment.total }.from(initial_value).to(expected_value)
      end
    end

    context 'when update rnd_percentage' do
      let(:expected_value) { 1.25 }

      it 'updates total' do
        expect { assignment.update(rnd_percentage: 15.0) }.to change{ assignment.total }.from(initial_value).to(expected_value)
      end
    end

    context 'when update total' do
      let(:expected_value) { 15.0 }

      it 'updates total' do
        expect { assignment.update(total: expected_value) }.to change{ assignment.total }.from(initial_value).to(expected_value)  
      end
    end

    context 'when update relation' do
      let(:project) { create(:project) }

      it 'does not update total' do
        expect { assignment.update(project: project) }.not_to change{ assignment.total }
      end
    end
  end

  describe 'update assignment employee or contractor total after changing assignment' do
    let!(:employee) { create(:employee) }
    let!(:assignments) { create_list(:assignment, 10, total: 10.0, rnd_percentage: 10.0, assignmentable: employee) }

    context 'when one of assignment has changed update user total' do
      it 'updates user totat' do
        expect{ assignments[0].update(months: 2) }.to change(employee, :total_apportionment).from(employee.total_apportionment).to(91.66666666666667)
      end
    end
  end
end
