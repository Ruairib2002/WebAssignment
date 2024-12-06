class AddRecipientIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :recipient_id, :integer
    add_index :messages, :recipient_id
  end
end
