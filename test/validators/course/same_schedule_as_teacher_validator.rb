class SameScheduleAsTeacherValidator < ActiveModel::Validator
    def validate(course)
        unless course.teacher.schedules.include?(course.schedule)
            course.errors[:schedule] << 'Course needs to have same schedule as the teacher asigned'
        end
    end
end