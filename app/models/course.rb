class Course < ApplicationRecord
    include ActiveModel::Validations
    belongs_to :teacher
    belongs_to :level
    belongs_to :schedule
    belongs_to :modality
    has_many :student_in_courses
    has_many :students, through: :student_in_courses
    validates_with SameScheduleAsTeacherValidator
end
