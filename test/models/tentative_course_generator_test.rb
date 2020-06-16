require 'test_helper'

class CourseConditionsTest < ActiveSupport::TestCase
    @@course_with_schedule = CourseWithScheduleCondition.new
    @@course_with_modality = CourseWithModalityCondition.new
    @@course_with_level = CourseWithLevelCondition.new
    @@course_with_same_schedule_as_teacher = CourseWithSameScheduleAsTeacherCondition.new
    @@course_with_same_schedule_modality_level_as_student = CourseWithSameScheduleModalityLevelAsStudentCondition.new

    test "Course by each schedule" do
        empty_course = Course.new
        generated_courses = @@course_with_schedule.generate_courses([empty_course])
        assert_equal Schedule.count, generated_courses.length
        generated_courses.each.with_index do |c, id|
            assert_equal Schedule.find(id + 1) , c.schedule
        end
    end

    test "Course by each modality" do
        empty_course = Course.new
        generated_courses = @@course_with_modality.generate_courses([empty_course])
        assert_equal Modality.count, generated_courses.length
        generated_courses.each.with_index do |c, id|
            assert_equal Modality.find(id + 1) , c.modality
        end
    end

    test "Course by each level" do
        empty_course = Course.new
        generated_courses = @@course_with_level.generate_courses([empty_course])
        assert_equal Level.count, generated_courses.length
        generated_courses.each.with_index do |c, id|
            assert_equal Level.find(id + 1) , c.level
        end
    end

    test "Combinatory of courses by modality, level, schedule" do
        empty_course = Course.new
        courses_by_schedule = @@course_with_schedule.generate_courses([empty_course])
        courses_by_modality_and_schedule = @@course_with_modality.generate_courses(courses_by_schedule)
        generated_courses = @@course_with_level.generate_courses(courses_by_modality_and_schedule)
        assert_equal Schedule.count * Modality.count * Level.count, generated_courses.length
    end

    test "Condition of same schedule as teacher" do
        course = Course.first
        course.schedule = Schedule.first
        teacher = Teacher.first
        teacher.schedules.push(Schedule.first)
        assert @@course_with_same_schedule_as_teacher.satisfy_condition?(course, teacher)
    end

    test "Course by each teacher with schedule thu9" do
        course = Course.new
        course.schedule_id = 4 #thu9
        generated_courses = @@course_with_same_schedule_as_teacher.generate_courses([course])
        assert_equal 2, generated_courses.length
        generated_courses.each.with_index do |c, id|
            assert_equal Teacher.find(id + 1) , c.teacher
        end
    end

    test "A student can join in the course" do
        course = Course.new
        course.schedule = Schedule.first
        course.modality = Modality.first
        course.level = Level.first
        student = Student.new
        student.schedules.push(Schedule.first)
        student.modality = Modality.first
        student.level = Level.first
        assert @@course_with_same_schedule_modality_level_as_student.satisfy_condition?(course, student)
    end
    
    test "Separate students of individual course" do
        student = Student.new
        students = [student, student, student]
        students_list = @@course_with_same_schedule_modality_level_as_student.split_students_by_modality(Modality.find(1), students)
        assert_equal 3, students_list.length

    end

    test "Separate students of groupal course with less students than max" do
        student = Student.new
        students = [student, student, student]
        assert_equal 1, @@course_with_same_schedule_modality_level_as_student.split_students_by_modality(Modality.find(2), students).length
    end

    test "Separate students of groupal course with more students than max" do
        student = Student.new
        students = [student, student, student, student, student, student, student]
        assert_equal 7, @@course_with_same_schedule_modality_level_as_student.split_students_by_modality(Modality.find(2), students).length
    end
    
    test "Course with students asigned" do
        empty_course = Course.new
        courses_by_schedule = @@course_with_schedule.generate_courses([empty_course])
        courses_by_modality_and_schedule = @@course_with_modality.generate_courses(courses_by_schedule)
        courses_by_level_modality_schedule = @@course_with_level.generate_courses(courses_by_modality_and_schedule)
        generated_courses = @@course_with_same_schedule_modality_level_as_student.generate_courses(courses_by_level_modality_schedule)
        assert_equal 4, generated_courses.length
        generated_courses.each do |course|
           assert_operator course.students.length, :<=, course.modality.max_students  # Reviso que los cursos creados si o si tengan estudantes
        end
    end

    test "Tentative Courses generated with conditions" do
        empty_course = Course.new
        generated_courses = @@course_with_schedule.generate_courses([empty_course])
        generated_courses = @@course_with_same_schedule_as_teacher.generate_courses(generated_courses)
        generated_courses = @@course_with_modality.generate_courses(generated_courses)
        generated_courses = @@course_with_level.generate_courses(generated_courses)
        generated_courses = @@course_with_same_schedule_modality_level_as_student.generate_courses(generated_courses)
        assert_equal 3, generated_courses.length
        generated_courses.each do |course|
            assert course.valid?
        end
    end

    test "Tentative Courses generated with generator" do
        generator = TentativeCoursesGenerator.new
        generator.conditions = [@@course_with_schedule, @@course_with_same_schedule_as_teacher, @@course_with_modality, @@course_with_level, @@course_with_same_schedule_modality_level_as_student]
        generated_courses = generator.generate_tentative_courses
        assert_equal 3, generated_courses.length
        generated_courses.each do |course|
            assert course.valid?
        end
    end

    test "Tentative Courses generated with generator are the same as generated with conditions" do
        empty_course = Course.new
        generated_courses_by_conds = @@course_with_schedule.generate_courses([empty_course])
        generated_courses_by_conds = @@course_with_same_schedule_as_teacher.generate_courses(generated_courses_by_conds)
        generated_courses_by_conds = @@course_with_modality.generate_courses(generated_courses_by_conds)
        generated_courses_by_conds = @@course_with_level.generate_courses(generated_courses_by_conds)
        generated_courses_by_conds = @@course_with_same_schedule_modality_level_as_student.generate_courses(generated_courses_by_conds)
        
        generator = TentativeCoursesGenerator.new
        generator.conditions = [@@course_with_schedule, @@course_with_same_schedule_as_teacher, @@course_with_modality, @@course_with_level, @@course_with_same_schedule_modality_level_as_student]
        generated_courses_by_gen = generator.generate_tentative_courses

        assert_equal generated_courses_by_conds.length, generated_courses_by_gen.length
        generated_courses_by_gen.each.with_index do |course, index|
            assert generated_courses_by_conds[index].attributes == course.attributes
        end
    end

end