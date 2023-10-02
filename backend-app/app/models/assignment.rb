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

  delegate :update_total_apportionment, to: :assignmentable

  after_save :update_total_apportionment

  belongs_to :assignmentable, polymorphic: true
  belongs_to :project

  scope :by_assignmentable, ->(id, type) { where(assignmentable_id: id, assignmentable_type: type) }

  validates :rnd_percentage, presence: true, numericality: { in: 0..100 }
  validates :months, presence: true, numericality: { in: 1..12 }
  validates :assignmentable_id, :assignmentable_type, :project_id, presence: true

  def update_total
    if months_changed? || rnd_percentage_changed?
      self.total = (months * rnd_percentage) / 12
    end
  end
end
