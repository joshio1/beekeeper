module Beekeeper
  class Logger
    def self.fatal(error)
      message = if error.respond_to? :backtrace
                  message_with_backtrace(error)
                else
                  error
                end
      Rails.logger.fatal message
    end

    def self.error(error)
      message = if error.respond_to? :backtrace
                  message_with_backtrace(error)
                else
                  error
                end
      Rails.logger.error message
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

  end
end

