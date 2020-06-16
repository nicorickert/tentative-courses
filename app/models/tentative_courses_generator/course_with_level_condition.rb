class CourseWithLevelCondition < CourseCondition
    def model_to_search
        return Level
    end

    def attribute_to_add
        return "level"
    end

    def satisfy_condition? _, _
        return true
    end
end
  