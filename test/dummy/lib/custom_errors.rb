class CustomErrors < Beekeeper::Error

  class InvalidRequest < CustomError
    def initialize(options = {})
      super(400, options[:message] || "The request you sent is invalid", options)
    end
  end

  class Unauthorized < CustomError
    def initialize(options = {})
      super(401, options[:message] || "You are not authorised to make this request", options)
    end
  end

  class Forbidden < CustomError
    def initialize(options = {})
      super(403, options[:message] || "You don’t have permission to access this resource", options)
    end
  end

  class RecordNotFound < CustomError
    def initialize(options = {})
      super(404, options[:message] || "The requested resource could not be found", options)
    end
  end

  class UnprocessableEntity < CustomError
    def initialize(options = {})
      super(422, options[:message] || "Request could not be processed", options)
    end
  end

  class BadGateway < CustomError
    def initialize(options = {})
      super(502, options[:message] || "Received an invalid response from the upstream server", options)
    end
  end

  class PreconditionRequired < CustomError
    def initialize(options = {})
      super(428, options[:message] || "The origin server requires the request to be conditional", options)
    end
  end

  class PreconditionFailed < CustomError
    def initialize(options = {})
      super(412, options[:message] || "The origin server did not satisfy the pre-condition of the request. Please check your request headers(if-modified-since and if-none-match).", options)
    end
  end

  class Apipie::Error
    def status
      400
    end
  end

end