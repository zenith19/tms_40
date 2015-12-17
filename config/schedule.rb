every 1.day, at: "0:15 am" do
  runner "DeadlineNotificationWorker.perform_async"
end