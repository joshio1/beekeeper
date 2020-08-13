require 'beekeeper/exception_blueprinter'
module Beekeeper
  module Rescuer
    extend ActiveSupport::Concern

    included do
      RESCUABLE_ERRORS = [
        ::CustomErrors::InvalidRequest,
        ::CustomErrors::Unauthorized,
        ::CustomErrors::Forbidden,
        ::CustomErrors::RecordNotFound,
        ::CustomErrors::UnprocessableEntity,
        ::CustomErrors::BadGateway,
        ::BaseError,
        ::Apipie::Error,
        ::ActiveRecord::RecordInvalid
      ]

      rescue_from(*RESCUABLE_ERRORS, with: :handle_error)

      def handle_error(error)
        log(error)
        response = ExceptionBlueprinter.render_as_hash error, view: :basic, request: request
        render json: response, status: response["status"]
      end

      def log(error)
        backtrace_cleaner = request.env["action_dispatch.backtrace_cleaner"]
        application_trace = ActionDispatch::ExceptionWrapper.new(backtrace_cleaner, error).application_trace
        application_trace.map! { |t| "  #{t}\n" }
        Rails.logger.error "\n#{error.class.name} (#{error.message}):\n#{application_trace.join}"
      end

    end

  end
end


