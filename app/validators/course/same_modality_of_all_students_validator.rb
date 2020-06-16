class Course::SameModalityOfAllStudentsValidator < ActiveModel::Validator
    def validate(course)
        unless course.students.all? { |st| st.modality.eql?(course.modality) }
            course.errors[:modality] << 'All students must have the same modality as the course'
        end
    end
end