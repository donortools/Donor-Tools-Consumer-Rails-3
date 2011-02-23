APP_CONFIG = YAML.load(File.read(RAILS_ROOT + "/config/app_config.yml"))[RAILS_ENV].symbolize_keys
