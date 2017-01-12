class CreateMeasuringUnits < ActiveRecord::Migration
  def change
    create_table :measuring_units do |t|
      t.text :measure

      t.timestamps null: false
    end
  end
end
