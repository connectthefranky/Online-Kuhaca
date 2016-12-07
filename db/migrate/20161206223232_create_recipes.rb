class CreateRecipes < ActiveRecord::Migration
  def change
  	drop_table :recipes

    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :ingredients

      t.timestamps null: false
    end
  end
end
