class RemoveIssueTypeFromIssues < ActiveRecord::Migration[7.1]
  def change
    remove_column :issues, :issue_type, :string
  end
end
