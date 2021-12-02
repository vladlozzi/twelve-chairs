require "test_helper"

class ChairsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chair = chairs(:one)
    @other_chair = "ChairOther"
  end

# Admin section
  test "should get index" do
    get chairs_path
    assert_redirected_to new_user_session_url
    follow_redirect!
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    assert_redirected_to chairs_url
    follow_redirect!
    assert_select 'h1', "Стільці, крісла, табурети"
    assert_select 'a', count: 3 + Chair.count * 3
    assert_select 'a[href="' + new_chair_path + '"]'
  end

  test "should get new" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get new_chair_url
    assert_response :success
  end

  test "should create chair" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @other_chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    end
    assert_redirected_to chair_url(Chair.last)
  end

  test "should not create same chair" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @chair.chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    end
    assert_response :unprocessable_entity
  end

  test "should not create zero-price chair" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @other_chair, price: 0.00, subcategory_id: @chair.subcategory_id } }
    end
    assert_response :unprocessable_entity
  end

  test "should not create negative-price chair" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @other_chair, price: -0.01, subcategory_id: @chair.subcategory_id } }
    end
    assert_response :unprocessable_entity
  end

  test "should show chair" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get chair_url(@chair)
    assert_response :success
  end

  test "should get edit" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get edit_chair_url(@chair)
    assert_response :success
  end

  test "should update chair" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    patch chair_url(@chair), params: { chair: { chair: @other_chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    assert_redirected_to chair_url(@chair)
  end

  test "should not update same chair into other subcategory" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    post chairs_url, params: { chair: { subcategory_id: subcategories(:one).id, chair: "Chair1", price: 100 } }
    assert_redirected_to chair_url(Chair.last)
    post chairs_url, params: { chair: { subcategory_id: subcategories(:one).id, chair: "Chair2", price: 200 } }
    assert_redirected_to chair_url(Chair.last)
    chair = Chair.last
    patch chair_url(chair), params: { chair: { subcategory_id: subcategories(:two).id, chair: "Chair1", price: 100 } }
    assert_response :unprocessable_entity
  end

  test "should destroy chair" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_difference('Chair.count', -1) do
      delete chair_url(@chair)
    end
    assert_redirected_to chairs_url
  end
# End of admin section

# Ordinary user section
  test "should get index without admin links" do
    get chairs_path
    assert_redirected_to new_user_session_url
    follow_redirect!
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    assert_redirected_to chairs_url
    follow_redirect!
    assert_select 'h1', "Стільці, крісла, табурети"
    assert_select 'a', count: 2 + Chair.count
    assert_select 'a[href="' + new_chair_path + '"]', count: 0
  end

  test "should not get new" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    get new_chair_url
    assert_redirected_to root_url
  end

  test "should not create chair" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @other_chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    end
    assert_redirected_to root_url
  end

  test "should show chair for ordinary user" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    get chair_url(@chair)
    assert_response :success
  end

  test "should not get edit" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    get edit_chair_url(@chair)
    assert_redirected_to root_url
  end

  test "should not update chair" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    patch chair_url(@chair), params: { chair: { chair: @other_chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    assert_redirected_to root_url
  end

  test "should not destroy chair" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Chair.count') do
      delete chair_url(@chair)
    end
    assert_redirected_to root_url
  end
# End of ordinary user section

end