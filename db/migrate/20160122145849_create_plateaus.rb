class CreatePlateaus < ActiveRecord::Migration
  def change
    create_table :plateaus do |t|
      t.integer :horizonal_cells_number
      t.integer :vertical_cells_number

      t.timestamps
    end
  end
end
