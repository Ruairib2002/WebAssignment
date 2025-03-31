class AddActiveToIssues < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :active, :boolean, default: true
  end
end
