class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :message_content
      t.integer :posted_by

      t.timestamps
    end
  end
end
