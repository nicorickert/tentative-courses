class Course::SameLevelOfAllStudentsValidator < ActiveModel::Validator
    def validate(course)
        unless course.students.all? { |st| st.level.eql?(course.level) }
            course.errors[:level] << 'All students must have the same level as the course'
        end
    end
end