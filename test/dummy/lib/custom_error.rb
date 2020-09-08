class CustomError < Beekeeper::Error

  def initialize(status_code, msg, options)
    super(status_code, msg, options)
  end

end