class UsersController < ApplicationController
  def index
    raise ActiveRecord::RecordInvalid
  end

  def create
    nil.hello
    render 200, {}
  end

  def show
    render 200, {}
  end
end
