class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.attachment :image_url
      t.timestamps null: false
    end
  end
end
