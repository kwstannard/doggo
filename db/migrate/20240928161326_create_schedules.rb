class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.date :date
      t.text :raw_assignments, default: '{}'

      t.timestamps
    end
  end
end
