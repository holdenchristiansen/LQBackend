class CreateCategoriesRecipes < ActiveRecord::Migration
  def change
    create_table :categories_recipes, id: false do |t|
	  t.references :category, index: true
	  t.references :recipe, index: true

      t.timestamps null: false
    end
    add_foreign_key :categories_recipes, :categories
    add_foreign_key :categories_recipes, :recipes

    #add_foreign_key :categories_recipes, :category #, column: :id, primary_key: "category_id"
	#add_foreign_key :categories_recipes, :category #, column: :id, primary_key: "recipe_id"
    #add_reference(:categories_recipes, :category, index: true, foreign_key:)
	#add_reference(:categories_recipes, :recipe, index: true, foreign_key:)
  end
end
