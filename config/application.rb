require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tbl
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.professor = "Your Name" # this is mostly just visible to you, but should be what your students call you.
    config.professor_email = "mkane2@albany.edu" # your email
    config.school_email_domain = "albany.edu" # The email domain that your users must use.
    config.site_name = "AHIS300 Quizzes" # What gets displayed on the browser tab
    config.default = "defaultpassword" # This will be your default password when the app is created.  Make sure you change your password in /users/edit when you log in the first time, and make sure your students change their emails as well!

    config.time_zone = 'Eastern Time (US & Canada)' #Set your time zone
  end
end
