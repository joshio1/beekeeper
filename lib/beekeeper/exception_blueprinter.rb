require 'blueprinter'
module Beekeeper
  class ExceptionBlueprinter < Blueprinter::Base

    view :basic do
      field :status do |exception, options|
        exception.try(:status) || get_status(exception, options)
      end
      field :message
      field :error do |exception, options|
        exception.try(:error) || get_error(exception, options)
      end
      field :errors do |exception, options|
        exception.try(:errors) || get_errors(exception)
      end
      field :data do |exception, options|
        exception.try(:data) || {}
      end
    end

    def self.get_status exception, options
      @status ||= exception.try(:status) || get_status_from_backtrace(exception, options)
    end

    def self.get_error exception, options
      status = get_status exception, options
      Rack::Utils::HTTP_STATUS_CODES.fetch(status, Rack::Utils::HTTP_STATUS_CODES[500])
    end

    def self.get_status_from_backtrace exception, options
      request = options[:request]
      backtrace_cleaner = request.env['action_dispatch.backtrace_cleaner']
      wrapper = ::ActionDispatch::ExceptionWrapper.new(backtrace_cleaner, exception)
      return wrapper.status_code
    end

    def self.get_errors exception
      return [
        {
          code: exception.class.name,
          message: exception.message
        }
      ]
    end

    private


  end
end

