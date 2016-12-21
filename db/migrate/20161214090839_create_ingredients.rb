class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredientes do |t|
      t.string :name

      t.timestamps null:false
    end
  end
end
