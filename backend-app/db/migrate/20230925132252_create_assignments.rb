class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.integer :months, null: false, default: 1
      t.float :rnd_percentage, null: false, default: 0.0
      t.float :total, null: false, default: 0.0
      t.belongs_to :employee, index: { unique: true }, foreign_key: true, null: false
      t.belongs_to :project, index: { unique: true }, foreign_key: true, null: false

      t.timestamps
    end
  end
end
