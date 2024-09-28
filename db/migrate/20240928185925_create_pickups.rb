class CreatePickups < ActiveRecord::Migration[7.2]
  def change
    create_table :pickups do |t|
      t.integer :dog_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
