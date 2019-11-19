class AddAttachmentImageHighlightUrlToIngredients < ActiveRecord::Migration
  def self.up
    change_table :ingredients do |t|
      t.attachment :image_highlight_url
    end
  end

  def self.down
    remove_attachment :ingredients, :image_highlight_url
  end
end
