job_type :rake,    "cd :path && :environment_variable=:environment SECRET_KEY_BASE=production_test_key bundle exec rake :task --silent :output"
set :output, {error: "log/cron_error_log.log", standard: "log/cron_log.log"}

every 5.minute do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake "send_email:test_mailer_cron"
end


