class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.belongs_to :teacher, null: false, foreign_key: true
      t.belongs_to :level, null: false, foreign_key: true
      t.belongs_to :schedule, null: false, foreign_key: true
      t.belongs_to :modality, null: false, foreign_key: true
      t.timestamps
    end
  end
end
