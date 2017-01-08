class AddRecipeIdToTag < ActiveRecord::Migration
  def change
    add_column :tags, :recipe_id, :integer
    add_index :tags, :recipe_id
  end
end
