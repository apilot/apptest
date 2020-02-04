require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.i18n.default_locale = :ru
    config.time_zone = 'Samara'
    config.exceptions_app = self.routes
    config.active_record.belongs_to_required_by_default = true
    config.generators do |g|
      g.helper        false
      g.javascripts   false
      g.stylesheets   false
      g.decorator     false
      g.template_engine :slim
      g.fixture_replacement :factory_girl, dir: "spec/factories"
      g.test_framework  :rspec,
        fixtures: true,
        view_spec: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
