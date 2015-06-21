require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hoge
  class Application < Rails::Application
    config.active_record.default_timezone = :local
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja

    config.generators.helper false
    config.generators.assets false
    config.generators.request_specs false
    config.generators.helper_specs false
    config.generators.routing_specs false
    config.generators.controller_specs false
    config.generators.view_specs false
    config.generators.fixture_replacement :factory_girl, dir: 'spec/factories'
    config.generators.test_framework :rspec, fixture: true
    config.generators.template_engine :haml

    config.active_record.raise_in_transactional_callbacks = true
  end
end
