class CourseWithModalityCondition < CourseCondition
    def model_to_search
        return Modality
    end

    def attribute_to_add
        return "modality"
    end

    def satisfy_condition? _, _
        return true
    end
end
  