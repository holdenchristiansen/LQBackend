class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :scratchedoffshoppingcart
      t.integer :shoppingcart
      t.string :name
      t.string :optionalassetname
      t.string :secondaryname
      t.string :type
      t.integer :cabinet

      t.timestamps null: false
    end
  end
end
