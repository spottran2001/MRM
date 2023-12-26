namespace :send_email do
  desc "Send notification mailer user"
  task :test_mailer_cron => :environment do
    p "MaintenanceMailer Start Time: " + Time.now.in_time_zone("Singapore").to_s + "\n\n"
    UserMailer.welcome_email(User.find(1)).deliver_now
    p "MaintenanceMailer End Time: " + Time.now.in_time_zone("Singapore").to_s + "\n\n"
  end
end
