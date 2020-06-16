class CourseWithScheduleCondition < CourseCondition
    def model_to_search
        return Schedule
    end

    def attribute_to_add
        return "schedule"
    end

    def satisfy_condition? _, _
        return true
    end
end
  