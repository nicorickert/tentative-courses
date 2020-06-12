class CreateStudentSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :student_schedules do |t|
      t.belongs_to :schedule, null: false, foreign_key: true
      t.belongs_to :student, null: false, foreign_key: true
      t.timestamps
    end
  end
end
