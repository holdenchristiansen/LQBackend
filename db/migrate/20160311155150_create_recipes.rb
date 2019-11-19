class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :alcoholic
      t.integer :drinkid
      t.integer :edited
      t.integer :favorite
      t.integer :issuggested
      #t.integer :glass_id
      t.references :glass
      t.references :recipe_steps
      t.text :information
      t.text :instructions
      t.string :name
      t.string :notes

      t.timestamps null: false
    end
    add_foreign_key :recipes, :glasses
  end
end
