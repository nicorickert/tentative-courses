class Course::MaxStudentsAccordingToModalityValidator < ActiveModel::Validator
    def validate(course)
        unless course.students.length <= course.modality.max_students
            course.errors[:modality] << 'The course can\'t have more than #{course.modality.max_students} students'
        end
    end
end