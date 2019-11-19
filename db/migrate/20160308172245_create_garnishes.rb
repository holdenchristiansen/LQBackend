class CreateGarnishes < ActiveRecord::Migration
  def change
    create_table :garnishes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
