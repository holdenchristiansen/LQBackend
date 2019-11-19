class AddImageUrlColumnsToGlasses < ActiveRecord::Migration
  def up
    add_attachment :glasses, :image_url
  end

  def down
    remove_attachment :glasses, :image_url
  end
end
