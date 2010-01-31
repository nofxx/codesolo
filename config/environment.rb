#
# Code Solo
#
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # config.frameworks -= [ :action_mailer ]
  config.time_zone = 'UTC'
  config.i18n.load_path += Dir[File.join(RAILS_ROOT, "lib", "locales", "*.{rb,yml}")]
  config.i18n.default_locale = "en"

#   config.gem "haml"
#   config.gem "authlogic"
#   config.gem "authlogic-oid", :lib => "authlogic_openid"
#   config.gem "ruby-openid", :lib => "openid"
#   config.gem "will_paginate"
#   config.gem "paperclip"
#   config.gem "octopi"
#   config.gem "api_cache", :lib => false
#   config.gem "nofxx-symbolize", :lib => "symbolize"

  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
end

