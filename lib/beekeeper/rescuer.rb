require 'beekeeper/exception_blueprinter'
module Beekeeper
  module Rescuer
    extend ActiveSupport::Concern

    included do
      RESCUABLE_ERRORS = [
        ::Beekeeper::Error,
        ::Apipie::Error,
        ::ActiveRecord::RecordInvalid
      ]

      rescue_from(*RESCUABLE_ERRORS, with: :handle_error)

      def handle_error(error)
        Logger.error(error)
        response = ExceptionBlueprinter.render_as_hash error, view: :basic, request: request
        render json: response, status: response[:status]
      end

    end

  end
end


