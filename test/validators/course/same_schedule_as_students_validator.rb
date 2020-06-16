class SameScheduleAsTeacherValidator < ActiveModel::Validator
    def validate(course)
        unless course.students.schedules.exists?(course.schedule)
            course.errors[:schedule] << 'Course needs to have same schedule as the teacher asigned'
        end
    end
end