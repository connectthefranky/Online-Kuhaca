class CreateMeasurement < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :recipe, index: true
      t.string :measure

      t.timestamps
    end
  end
end
