class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_variables

  def prepare_variables
    @professor = Rails.configuration.professor # Your name
    @site_name = Rails.configuration.site_name # What gets displayed on the browser tab
    @professor_email = Rails.configuration.professor_email # your email
    @school_email_domain = Rails.configuration.school_email_domain # The email domain that your users must use.
    @defaultpassword = Rails.configuration.default
  end
end
