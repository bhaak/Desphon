# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '1.2.6' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
   config.log_level = :debug
   config.logger = Logger.new(config.log_path, 'daily') # http://www.ruby-doc.org/core/classes/Logger.html

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add pluralization for german words
Inflector.inflections do |i|
	i.irregular 'autor', 'autoren'
	i.irregular 'onlinetext', 'onlinetexte'
	i.irregular 'typ', 'typen'
	i.irregular 'produkt', 'produkte'
	i.irregular 'fehler', 'fehler'
end

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile

# Include your application configuration below

  
# mehrfaches suchen-und-ersetzen in einem Aufruf
class String
	def normalisiert
		return self.downcase.gsub(/Ä/, 'ae').gsub(/ä/, 'ae').gsub(/Ö/, 'oe').gsub(/ö/, 'oe').gsub(/Ü/, 'ue').gsub(/ü/, 'ue').gsub(/ß/, 'ss')
	end

	def suchmaschinenfreundlich
		return self.normalisiert.gsub(/[^a-zA-Z0-9]+/, '-')
	end
end


class Time
	MONAT = [ '', 'Januar', 'Februar', 'M&auml;rz', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember' ]
	def html_datum
		return day.to_s+". "+MONAT[month]+" "+year.to_s+", "+strftime("%H:%M")
	end
end

# undefined method `[]' for #<Enumerable::Enumerator:0xb6f614c0>
# http://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg528878.html
unless '1.9'.respond_to?(:force_encoding)
  String.class_eval do
    begin
      remove_method :chars
    rescue NameError
      # OK
    end
  end
end
