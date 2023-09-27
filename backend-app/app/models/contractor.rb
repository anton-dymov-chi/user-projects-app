class Contractor < Employee
  has_many :assignments, as: :assignmentable
  has_many :projects, trhough: :assignments
end
