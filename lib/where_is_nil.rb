require 'where_is_nil/version'
require 'where_is_nil/config'
require 'where_is_nil/active_record'
require 'where_is_nil/error'

module WhereIsNil
  def self.config
    @@config ||= WhereIsNil::Config.instance
  end

  def self.logger
    config.logger
  end

  def self.logger=(value)
    config.logger = value
  end
end
