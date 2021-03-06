class UserMailer < ApplicationMailer  
  def assigned_supervisors user_full_name, user_email, course_id
    @course = Course.find course_id
    @user_full_name = user_full_name
    mail to: user_email, subject: default_i18n_subject(course_name: @course.name)
  end

  def removed_supervisors user_full_name, user_email, course_id
    @course = Course.find course_id
    @user_full_name = user_full_name
    mail to: user_email, subject: default_i18n_subject(course_name: @course.name)
  end

  def assigned_trainees user_full_name, user_email, course_id
    @course = Course.find course_id
    @user_full_name = user_full_name
    mail to: user_email, subject: default_i18n_subject(course_name: @course.name)
  end

  def removed_trainees user_full_name, user_email, course_id
    @course = Course.find course_id
    @user_full_name = user_full_name
    mail to: user_email, subject: default_i18n_subject(course_name: @course.name)
  end

  def notify_deadline user_full_name, user_email, course_id
    @course = Course.find course_id
    @user_full_name = user_full_name
    mail to: user_email, subject: default_i18n_subject(course_name: @course.name)
  end

  def daily_report supervisor_id
    @supervisor = User.find supervisor_id
    mail to: @supervisor.email, subject: default_i18n_subject
  end
end