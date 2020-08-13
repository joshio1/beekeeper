module Beekeeper
  class Error < StandardError

    attr_reader :status_code, :errors, :data, :status

    def initialize(status_code, msg, options = {})
      super(msg)
      @status_code = status_code
      @errors = get_errors(options)
      @data = options[:data] || {}
      @status = @status_code
    end

    def get_errors(options)
      return [options.delete(:error)] if options[:error].present?
      return options[:errors].errors().messages() if options[:errors].class < ActiveRecord::Base
      return options[:error_map] if options[:error_map]
      return options[:errors] || [{
        code: class_name(options),
        message: self.message
      }]
    end

    private

    def class_name options
      return options[:exception].class.to_s if options[:exception].present?
      self.class.to_s
    end
  end
end

