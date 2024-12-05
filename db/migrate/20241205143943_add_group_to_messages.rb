class AddGroupToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :group_id, :integer
  end
end
