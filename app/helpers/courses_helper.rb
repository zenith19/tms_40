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
end
