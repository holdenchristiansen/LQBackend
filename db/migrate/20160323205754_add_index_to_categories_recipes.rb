class AddIndexToCategoriesRecipes < ActiveRecord::Migration
  def change
  	add_index :categories_recipes, [:category_id, :recipe_id]
  end
end
