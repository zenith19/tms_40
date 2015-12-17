class DailyReportWorker
  include Sidekiq::Worker

  def perform
    User.supervisors.each do |supervisor|
      UserMailer.daily_report(supervisor.id).deliver_now
    end    
  end
end