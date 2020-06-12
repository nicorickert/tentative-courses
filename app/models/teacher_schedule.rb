class TeacherSchedule < ApplicationRecord
    belongs_to :schedule
    belongs_to :teacher
end
