class AddIssueTypeToIssues < ActiveRecord::Migration[7.1]
  def change
    add_column :issues, :issue_type, :string
  end
end
