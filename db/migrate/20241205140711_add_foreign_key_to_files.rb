class AddForeignKeyToFiles < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :files, :users, column: :uploaded_by
  end
end
