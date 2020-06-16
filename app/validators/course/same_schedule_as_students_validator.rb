class Course::SameScheduleAsTeacherValidator < ActiveModel::Validator
    def validate(course)
        unless course.students.all? { |st| st.schedules.exists?(course.schedule) }
            course.errors[:schedule] << 'Course needs to have same schedule as the students asigned'
        end
    end
end