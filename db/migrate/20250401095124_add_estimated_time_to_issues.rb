class AddEstimatedTimeToIssues < ActiveRecord::Migration[7.1]
  def change
    add_column :issues, :estimated_time, :float
  end
end
