module Beekeeper
  class Logger
    def self.fatal(error)
      bc = ActiveSupport::BacktraceCleaner.new
      bc.add_filter   { |line| line.gsub(Rails.root.to_s, '') } # strip the Rails.root prefix
      bc.add_silencer { |line| line =~ /puma|rubygems|vendor|bin/ } # skip any lines from puma or rubygems
      trace = bc.clean(error.backtrace)
      Rails.logger.fatal "\n#{error.class.name} (#{error.message}):\n#{trace.join}"
    end
  end
end

