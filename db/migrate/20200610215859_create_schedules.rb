class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.integer :hour
      t.belongs_to :day_of_the_week, null: false, foreign_key: true

      t.timestamps
    end
  end
end
