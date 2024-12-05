class ChangeUploadedByTypeInFiles < ActiveRecord::Migration[6.0]
  def change
    change_column :files, :uploaded_by, :bigint
  end
end
