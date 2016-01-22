class CreateRovers < ActiveRecord::Migration
  def change
    create_table :rovers do |t|
      t.integer :x
      t.integer :y
      t.string :heading
      t.integer :plateau_id

      t.timestamps
    end
  end
end
