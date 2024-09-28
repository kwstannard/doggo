class CreateTrips < ActiveRecord::Migration[7.2]
  def change
    create_table :trips do |t|
      t.integer :truck_id
      t.date :date
      t.boolean :arrived
      t.boolean :departed

      t.timestamps
    end
  end
end
