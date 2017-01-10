class CreateRecipeTags < ActiveRecord::Migration
  def change
    create_table :recipe_tags do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :recipe, index: true

      t.timestamps null: false
    end
  end
end
