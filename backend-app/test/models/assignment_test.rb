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
require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
