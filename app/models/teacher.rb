class Teacher < ApplicationRecord
    has_many :teacher_schedules
    has_many :schedules , through: :teacher_schedules
end
