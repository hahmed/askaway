Airbrake.configure do |config|
  config.host = 'https://funky-errors.herokuapp.com'
  config.project_id = 1 # required, but any positive integer works
  config.project_key = '972afefa2eea6ff117f8d9e58beee44e'

  # Uncomment for Rails apps
  config.environment = Rails.env
  config.ignore_environments = %w(test development)
end
