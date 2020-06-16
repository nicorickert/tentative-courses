class CourseWithSameScheduleAsTeacherCondition < CourseCondition
    def model_to_search
        return Teacher
    end

    def attribute_to_add
        return "teacher"
    end

    def verify_requirements course
        if course.schedule.nil?
            raise("The course needs a schedule to generate with this condition")
        end
    end

    def satisfy_condition? course, teacher
        verify_requirements(course)
        return teacher.schedules.include?(course.schedule)
    end
end
  