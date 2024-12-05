class CreateFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :files do |t|
      t.string :file_name
      t.integer :uploaded_by
      t.string :file_path
      t.timestamp :uploaded_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
