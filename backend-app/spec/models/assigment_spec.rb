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
  end
end
