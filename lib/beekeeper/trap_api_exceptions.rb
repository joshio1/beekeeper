require 'beekeeper/exception_blueprinter'
class Beekeeper::Railtie
  initializer 'beekeeper.trap_api_exceptions' do |app|
    # Global exception handler. No need of any exception handling in the application code.
    app.middleware.insert_after(ActionDispatch::ShowExceptions, Beekeeper::TrapApiExceptions)
  end
end

module Beekeeper
  class TrapApiExceptions
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new env
      @app.call(env)
    rescue StandardError => e
      # if request.path_info.include? '/api'
        render_json_error(request, e)
      # else
      #   raise e
      # end
    end

    private

    def render_json_error(request, exception)
      response = ExceptionBlueprinter.render_as_hash(exception, view: :basic, request: request)
      body = response.to_json
      return [
        response[:status],
        {
          'Content-Type' => "json; charset=#{::ActionDispatch::Response.default_charset}",
          'Content-Length' => body.bytesize.to_s
        },
        [body]
      ]
    end

    def get_status(request, exception)
      backtrace_cleaner = request.get_header 'action_dispatch.backtrace_cleaner'
      wrapper = ::ActionDispatch::ExceptionWrapper.new(backtrace_cleaner, exception)
      return wrapper.status_code
    end

    def get_error(status)
      Rack::Utils::HTTP_STATUS_CODES.fetch(status, Rack::Utils::HTTP_STATUS_CODES[500])
    end

    def get_errors(exception)
      return [
        {
          code: exception.class.name,
          message: exception.message
        }
      ]
    end
  end
end
