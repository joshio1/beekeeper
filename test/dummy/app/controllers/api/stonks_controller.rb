class Api::StonksController < ApplicationController
  def index
    nil.dummy_method_which_never_gets_called
  end

  def create
    raise ::CustomErrors::UnprocessableEntity, message: "Stonks are too high at this point.", data: {entity: "dummy_data"}
  end

  api :POST, '/stonks/new'
  param :stonk_quantity, :number, required: true, desc: 'Stonk Quanity to create'
  def new
    render json: {}
  end

end

