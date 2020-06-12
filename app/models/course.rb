class Course < ApplicationRecord
    belongs_to :teacher
    belongs_to :level
    belongs_to :schedule
    belongs_to :modality # ver si va aca o se calcula en un metodo
    has_many :student_in_courses

end
