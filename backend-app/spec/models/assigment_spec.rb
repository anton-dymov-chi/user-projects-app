require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'validation tests' do
    let(:rnd_percentage) { 12.0 }
    let(:months) { 6 }
    let(:project_id) { create(:project).id }
    let(:assignmentable_id) { create(:employee).id }
    let(:assignmentable_type) { 'Employee' } 
    let(:assignment) do 
      build(:assignment, 
            rnd_percentage: rnd_percentage, 
            months: months, 
            project_id: project_id, 
            assignmentable_id: assignmentable_id,
            assignmentable_type: assignmentable_type
          )
    end

    context 'rnd_percentage' do
      context "when valid" do
        it 'is valid' do
          expect(assignment).to be_valid
        end
      end

      context 'when invalid' do
        context 'when rnd_percentage is empty' do
          let(:rnd_percentage) { nil }

          it 'is invalid' do
            expect(assignment).to be_invalid  
          end
        end

        context 'when rnd_pecentage is a string' do
          let(:rnd_percentage) { 'invalid' }

          it 'is invalid' do
            expect(assignment).to be_invalid  
          end
        end
      end

      context 'when out of range' do
        let(:rnd_percentage) { 100.1 }

        it 'is invalid' do
          expect(assignment).to be_invalid 
        end
      end
    end

    context 'months' do
      context 'when valid' do
        it 'is valid' do
          expect(assignment).to be_valid  
        end
      end

      context 'when invalid' do
        context 'when empty' do
          let(:months) { nil }

          it 'is invalid' do
            expect(assignment).to be_invalid  
          end
        end

        context 'when out of the range' do
          let(:months) { 13 }

          it 'is invalid' do
            expect(assignment).to be_invalid  
          end
        end

        context 'when string' do
          let(:months) { 'invalid' }

          it 'is invalid' do
            expect(assignment).to be_invalid
          end
        end        
      end
    end
  end

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
