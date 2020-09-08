# users_controller_test.rb
class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should return unprocessable entity" do
    get '/users'
    assert_response :unprocessable_entity
    response_json = JSON.parse(response.body)
    assert_equal response_json['data'], {}
    assert_equal response_json['error'], "Unprocessable Entity"
    assert_equal response_json['errors'][0]['code'], "ActiveRecord::RecordInvalid"
    assert_equal response_json['errors'][0]['message'], "Record invalid"
    assert_equal response_json['message'], "Record invalid"
    assert_equal response_json['status'], 422
  end

end
