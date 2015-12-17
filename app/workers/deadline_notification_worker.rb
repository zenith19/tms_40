class DeadlineNotificationWorker
  include Sidekiq::Worker

  def perform
    courses = Course.near_deadline
    courses.each do |course|
      course.users.each do |user|
        UserMailer.notify_deadline(user.full_name, user.email, course.id).
          deliver_now
      end
    end    
  end
end