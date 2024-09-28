class CreateDogs < ActiveRecord::Migration[7.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.boolean :Monday
      t.boolean :Tuesday
      t.boolean :Wednesday
      t.boolean :Thursday
      t.boolean :Friday

      t.timestamps
    end
  end
end
