every 1.day, at: "0:15 am" do
  runner "DeadlineNotificationWorker.perform_async"
end

every 1.day, at: "7:00 pm" do
  runner "DailyReportWorker.perform_async"
end