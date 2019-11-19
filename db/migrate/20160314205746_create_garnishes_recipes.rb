class CreateGarnishesRecipes < ActiveRecord::Migration
  def change
    create_table :garnishes_recipes do |t|
	  t.references :garnish, index: true
	  t.references :recipe, index: true

      t.timestamps null: false
    end
    add_foreign_key :garnishes_recipes, :garnishes
    add_foreign_key :garnishes_recipes, :recipes
  end
end
