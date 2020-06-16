class TentativeCoursesGenerator
    @conditions = []    # array of course_conditions's subclasses

    def conditions= conditions
        @conditions = conditions
    end

    def add_condition condition
        @conditions.push(condition)
    end

    def generate_tentative_courses
        tentative_courses = [Course.new]
        @conditions.each do |cond|
            tentative_courses = cond.generate_courses(tentative_courses)
        end
        return tentative_courses
    end
end