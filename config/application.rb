require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RsCiAppRails
  class Application < Rails::Application
    # These are bogus values so that specs can run without failing
    config.rs_email = "email"
    config.rs_password = "pass"
    config.rs_account_id = "acct"
  end
end
