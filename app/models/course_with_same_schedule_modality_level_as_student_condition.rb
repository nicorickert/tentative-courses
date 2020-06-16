class CourseWithSameScheduleModalityLevelAsStudentCondition < CourseCondition
    
    def load_generated_courses generated_courses, models, course
        if models.any? # Generate course if students exists
            students_list = split_students_by_modality(course.modality, models)
            students_list.each do |students|
                new_course = course.dup # Duplicate course with same params
                new_course.students = students
                generated_courses.push(new_course)
            end
        end
    end

    def split_students_by_modality modality, students
        if students.length <= modality.max_students
            return [students]   # Needs to return an array of arrays
        else
            return students.combination(modality.max_students).to_a
        end
    end

    def model_to_search
        return Student
    end

    def attribute_to_add
        return "students"
    end

    def verify_requirements course
        if course.schedule.nil?
            raise("To generate with this condition, the course needs a schedule")
        elsif course.modality.nil?
            raise("To generate with this condition, the course needs a modality")
        elsif course.level.nil?
            raise("To generate with this condition, the course needs a level")
        end
    end

    def satisfy_condition? course, student
        verify_requirements(course)
        return (student.schedules.include?(course.schedule) and student.modality.eql?(course.modality) and student.level.eql?(course.level))
    end
end