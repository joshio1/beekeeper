module Beekeeper
  class Logger
    def self.fatal(error, logger: nil)
      message = if error.respond_to? :backtrace
                  message_with_backtrace(error)
                else
                  error
                end
      internal_logger(logger).fatal message
    end

    def self.error(error, logger: nil)
      message = if error.respond_to? :backtrace
                  message_with_backtrace(error)
                else
                  error
                end
      internal_logger(logger).error message
    end

    private

    def self.message_with_backtrace(error)
      trace = clean(error.backtrace)
      "\n#{error.class.name} (#{error.message}):\n#{trace.join}"
    end

    def self.clean(backtrace)
      bc = ActiveSupport::BacktraceCleaner.new
      bc.add_filter   { |line| line.gsub(Rails.root.to_s, '') } # strip the Rails.root prefix
      bc.add_silencer { |line| line =~ /puma|rubygems|vendor|bin/ } # skip any lines from puma or rubygems
      bc.clean(backtrace).map! { |t| "  #{t}\n" }
    end

    def self.internal_logger(logger)
      logger || Rails.logger
    end

  end
end

