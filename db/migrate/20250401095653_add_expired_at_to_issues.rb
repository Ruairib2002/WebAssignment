class AddExpiredAtToIssues < ActiveRecord::Migration[7.1]
  def change
    add_column :issues, :expired_at, :datetime
  end
end
