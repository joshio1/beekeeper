# users_controller_test.rb
module Api
  class StonksControllerTest < ActionDispatch::IntegrationTest

    test "should return an internal server error" do
      get '/api/stonks/'
      assert_response :internal_server_error
      assert_equal response.header['Content-Type'], 'json; charset=UTF-8'

      expected_response = {
        "data": {},
        "error": "Internal Server Error",
        "errors": [
          {"code": "NoMethodError",
            "message": "undefined method `dummy_method_which_never_gets_called' for nil:NilClass"}],
        "message": "undefined method `dummy_method_which_never_gets_called' for nil:NilClass",
        "status": 500
      }

      assert_equal JSON.parse(response.body).to_json, expected_response.to_json
    end

    test "should return an unprocessable entity" do
      post '/api/stonks/'
      assert_response :unprocessable_entity
      assert_equal response.header['Content-Type'], 'application/json; charset=utf-8'


      expected_response = {
        "data": {
          entity: "dummy_data"
        },
        "error": "Unprocessable Entity",
        "errors": [
          {"code": "CustomErrors::UnprocessableEntity",
            "message": "Stonks are too high at this point."}],
        "message": "Stonks are too high at this point.",
        "status": 422
      }

      assert_equal JSON.parse(response.body).to_json, expected_response.to_json
    end

    test "should return a bad request error" do
      post '/api/stonks/new'
      assert_response :bad_request
      assert_equal response.header['Content-Type'], 'application/json; charset=utf-8'

      expected_response = {
        "data": {},
        "error": "Bad Request",
        "errors": [
          {"code": "Apipie::ParamMissing",
            "message": "Missing parameter stonk_quantity"}],
        "message": "Missing parameter stonk_quantity",
        "status": 400
      }

      assert_equal JSON.parse(response.body).to_json, expected_response.to_json
    end
  end
end

