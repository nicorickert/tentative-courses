class CreateTeacherSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_schedules do |t|
      t.belongs_to :schedule, null: false, foreign_key: true
      t.belongs_to :teacher, null: false, foreign_key: true
      t.timestamps
    end
  end
end
