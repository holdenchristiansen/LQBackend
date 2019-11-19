class CreateVersionHistories < ActiveRecord::Migration
  def change
    create_table :version_histories do |t|
      t.integer :version
      t.string :table_name
      t.string :action
      t.string :primary_keys
      t.string :change_fields
      t.timestamps null: false
    end
  end
end
