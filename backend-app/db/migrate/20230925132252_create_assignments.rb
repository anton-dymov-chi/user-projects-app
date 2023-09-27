class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.integer :months, null: false, default: 1
      t.float :rnd_percentage, null: false, default: 0.0
      t.float :total, null: false, default: 0.0
      t.belongs_to :project, foreign_key: true, null: false
      t.references :assignmentable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :assignments, 
              [:project_id, :assignmentable_type, :assignmentable_id], 
              unique: true,
              name: 'index_assignments_on_project_id_unique_to_assignmentable'
  end
end
