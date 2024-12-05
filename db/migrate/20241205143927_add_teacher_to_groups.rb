class AddTeacherToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :teacher_id, :integer
  end
end
