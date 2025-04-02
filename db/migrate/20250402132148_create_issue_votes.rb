class CreateIssueVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :issue_votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :issue, null: false, foreign_key: true
      t.boolean :resolved, default: false  # Track if the user resolved the issue

      t.timestamps
    end

    add_index :issue_votes, [:user_id, :issue_id], unique: true
  end
end
