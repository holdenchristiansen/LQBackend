class CreateListsRecipes < ActiveRecord::Migration
  def change
  	create_table :lists_recipes, id: false do |t|
		t.references :list, index: true
		t.references :recipe, index: true
      	t.timestamps null: false
    end
    add_foreign_key :lists_recipes, :lists
    add_foreign_key :lists_recipes, :recipes
  end
end
