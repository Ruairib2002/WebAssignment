class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
