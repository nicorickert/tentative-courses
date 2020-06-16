class Schedule < ApplicationRecord
    validates :hour, numericality: { greater_than_or_equal_to: 9, less_than_or_equal_to: 19 }, presence: true
    belongs_to :day_of_the_week
    #has_many :teacher_schedules
    #has_many :teachers, through :teacher_schedules
    #has_many :student_schedules
    #has_many :students, through :student_schedules
    validates_associated :day_of_the_week
end
