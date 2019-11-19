class CreateSimilarRecipes < ActiveRecord::Migration
  def change
    create_table :similar_recipes do |t|
	  t.references :recipe, index: true
	  t.integer  :reflexive_id

      t.timestamps null: false
    end
    add_foreign_key :similar_recipes, :recipes

  end
end
