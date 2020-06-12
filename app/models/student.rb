class Student < ApplicationRecord
    belongs_to :level
    belongs_to :modality
    has_many :student_schedules
    has_many :schedules, through :student_schedules
end
