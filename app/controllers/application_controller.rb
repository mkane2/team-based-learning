class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  @professor = Tbl::Application.config.professor # Your name
  @site_name = Tbl::Application.config.site_name # What gets displayed on the browser tab
  @professor_email = Tbl::Application.config.professor_email # your email
  puts @professor_email
  @school_email_domain = Tbl::Application.config.school_email_domain # The email domain that your users must use.
  @defaultpassword = Tbl::Application.config.default
end
