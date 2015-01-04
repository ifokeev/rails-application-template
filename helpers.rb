def database_username
  return @database_username if defined?(@database_username)
  @database_username = ask("Enter dev DB username (#{ENV['USER']}):")
  @database_username = ENV['USER'] if @database_username.blank?
end

def use_sorcery?
  return @use_sorcery if defined?(@use_sorcery)
  @use_sorcery = yes?('Generate barebones authentication using Sorcery?')
end

def use_devise?
  return @use_devise if defined?(@use_devise)
  @use_devise = yes?('Would you like to install Devise?')
end

def use_admin?
  return @use_admin if defined?(@use_admin)
  @use_admin = ask("Install rails_admin or active_admin? [1, 2]")
end

def require_ssl?
  return @require_ssl if defined?(@require_ssl)
  @require_ssl = yes?('Will this application require SSL in production?')
end

def cat(filename)
  File.read(File.expand_path(File.join(File.dirname(__FILE__), 'templates', filename)))
end

def erb(filename)
  ERB.new(cat(filename)).result(binding)
end