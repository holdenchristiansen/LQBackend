class AddAttachmentImageUrlToIngredients < ActiveRecord::Migration
  def self.up
    change_table :ingredients do |t|
      t.attachment :image_url
    end
  end

  def self.down
    remove_attachment :ingredients, :image_url
  end
end
