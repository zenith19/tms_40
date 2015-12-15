module CoursesHelper

  def find_subject_progress sub_id
    courses_subject = CoursesSubject.find_by_course_id_and_subject_id @course.id, sub_id
    tasks = Array.new
    tasks = courses_subject.tasks
    total_tasks_no = tasks.size
    completed_tasks_no = 0
    tasks.each do |task|
      user_task = UsersTask.find_by_user_id_and_task_id current_user.id, task.id 
      if user_task.present? 
        completed_tasks_no += 1
      end
      user_task = nil
    end
    unless total_tasks_no == 0
      percent = (completed_tasks_no/total_tasks_no) * 100  
    else
      percent = 0
    end
    return percent
  end

  def find_course_percent
    total_subjects_no = 0
    completed_subjects_no = 0
    @subjects.each do |subject|
      courses_subject = CoursesSubject.find_by_course_id_and_subject_id @course.id, subject.id
      unless courses_subject.status
        completed_subjects_no += 1   
      end
      total_subjects_no += 1
    end
    unless total_subjects_no == 0
      course_percent = (completed_subjects_no / total_subjects_no) * 100 
    else
      course_percent = 0
    end
    return course_percent
  end
end
