class CreateRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.integer :stepindex
      t.references :recipe, foreign_key: true
      t.text :stepamount
      t.text :steptitle
      t.timestamps null: false
    end
  end
end
