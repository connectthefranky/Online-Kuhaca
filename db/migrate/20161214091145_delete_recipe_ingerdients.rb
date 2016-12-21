class DeleteRecipeIngerdients < ActiveRecord::Migration
  def change
    remove_column :recipes, :ingredientes
  end
end
