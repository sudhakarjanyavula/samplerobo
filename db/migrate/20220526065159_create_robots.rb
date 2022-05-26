class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.string :facing
      t.integer :x_coordinate
      t.integer :y_coordinate

      t.timestamps
    end
  end
end
