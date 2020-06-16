class CourseCondition

    def generate_courses initial_courses
        generated_courses = []
        initial_courses.each do |course|
            generated_courses.concat(generate_courses_by_each(course))
        end
        return generated_courses
    end

    def generate_courses_by_each course
        generated_courses = []
        filtered_models = model_to_search().all.select { |m| satisfy_condition?(course, m) }
        load_generated_courses(generated_courses, filtered_models, course)
        return generated_courses
    end

    def load_generated_courses generated_courses, models, course
        models.each do |m|
            new_course = course.dup # Duplicate course with same params
            new_course.association(attribute_to_add()).writer(m)
            generated_courses.push(new_course)
        end
    end
    
    # "Abstract" methods
    def attribute_to_add    # Name of Course's attribute to add in this condition
        raise NotImplementedError, "Subclasses must define `attribute_to_add`."
    end

    def model_to_search     # Class of Course's attribute type 
        raise NotImplementedError, "Subclasses must define `model_to_search`."
    end

    def satisfy_condition? course, model # The condition needed to meet
        raise NotImplementedError, "Subclasses must define `satisfy_condition?`."
    end

end  