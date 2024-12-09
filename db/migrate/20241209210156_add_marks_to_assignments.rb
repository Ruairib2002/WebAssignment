class AddMarksToAssignments < ActiveRecord::Migration[7.1]
  def change
    add_column :assignments, :marks, :json
  end
end
