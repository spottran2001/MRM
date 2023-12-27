namespace :send_email do
  desc "Send notification mailer user"
  task :configuration => :environment do
    p "MaintenanceMailer Start Time: " + Time.now.to_s + "\n\n"
    ::Configuration.last.mailer
    p "MaintenanceMailer End Time: " + Time.now.to_s + "\n\n"
  end
end
