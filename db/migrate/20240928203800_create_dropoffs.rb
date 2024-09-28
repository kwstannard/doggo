class CreateDropoffs < ActiveRecord::Migration[7.2]
  def change
    create_table :dropoffs do |t|
      t.integer :dog_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
