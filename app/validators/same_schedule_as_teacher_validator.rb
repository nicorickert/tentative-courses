class SameScheduleAsTeacherValidator < ActiveModel::Validator
    def validate(course)
        unless course.teacher.schedules.include? course.schedule
            course.errors[:teacher] << 'El horario debe coincidir con el del docente'
        end
    end
end