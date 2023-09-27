class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.float :salary
      t.float :total_apportionment

      t.timestamps
    end

    add_index :employees, :name
  end
end
