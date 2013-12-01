Bundler.require # Require all the gems in the Gemfile
require "./app"

I18n.default_locale = :en
I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config', 'locales', '*.yml').to_s]

run App
