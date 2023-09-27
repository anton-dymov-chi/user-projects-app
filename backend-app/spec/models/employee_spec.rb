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
  pending "add some examples to (or delete) #{__FILE__}"
end
