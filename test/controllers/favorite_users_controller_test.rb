require 'test_helper'

class FavoriteUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get favorite_users_index_url
    assert_response :success
  end

end
