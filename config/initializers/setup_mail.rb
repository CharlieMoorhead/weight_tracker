ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address               => "smtp.gmail.com",
  :port                  => 587,
  :domain                => "gmail.com",
  :user_name             => "charlie.robot.email@gmail.com",
  :password              => "Gorilla Cheese Horse Sandwich",
  :authentication        => "plain",
  :enable_starttls_auto  => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
