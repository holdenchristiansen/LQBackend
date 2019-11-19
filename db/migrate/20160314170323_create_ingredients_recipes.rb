class CreateIngredientsRecipes < ActiveRecord::Migration
  def change
    create_table :ingredients_recipes do |t|
	  t.references :ingredient, index: true
	  t.references :recipe, index: true

      t.timestamps null: false
    end
	add_foreign_key :ingredients_recipes, :ingredients
    add_foreign_key :ingredients_recipes, :recipes

  end
end
