module WhereIsNil
  class Config
    attr_accessor :enabled, :warning_log, :raise_error, :not_found, :logger
    include Singleton

    def initialize
      init
    end

    def init
      @enabled = true
      @warning_log = true
      @raise_error = true
      @not_found = false

      @logger = Rails.logger
    end
  end
end
