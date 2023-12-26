set :output, {error: "log/cron_error_log.log", standard: "log/cron_log.log"}

every 5.minute do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake "send_email:test_mailer_cron"
end


