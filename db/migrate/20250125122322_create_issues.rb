class CreateIssues < ActiveRecord::Migration[7.1]
  def change
    create_table :issues do |t|
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
