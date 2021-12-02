require "test_helper"

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subcategory = subcategories(:one)
    @other_subcategory = "OtherSubcategory"
  end

# Admin section
  test "should get index" do
    get subcategories_path
    assert_redirected_to new_user_session_url
    follow_redirect!
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    assert_redirected_to subcategories_url
    follow_redirect!
    assert_select 'h1', "Subcategories"
    assert_select 'a', count: 4 + Subcategory.count * 3
    assert_select 'a[href="' + new_subcategory_path + '"]'
  end

  test "should get new" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get new_subcategory_url
    assert_response :success
  end

  test "should create subcategory" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_difference('Subcategory.count') do
      post subcategories_url, params: { subcategory: { category_id: @subcategory.category_id, subcategory: @other_subcategory } }
    end
    assert_redirected_to subcategory_url(Subcategory.last)
  end

  test "should not create same subcategory" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Subcategory.count') do
      post subcategories_url, params: { subcategory: { category_id: @subcategory.category_id, subcategory: @subcategory.subcategory } }
    end
    assert_response :unprocessable_entity
  end

  test "should show subcategory" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get subcategory_url(@subcategory)
    assert_response :success
  end

  test "should get edit" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get edit_subcategory_url(@subcategory)
    assert_response :success
  end

  test "should update subcategory" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    patch subcategory_url(@subcategory), params: { subcategory: { category_id: @subcategory.category_id, subcategory: @other_subcategory } }
    assert_redirected_to subcategory_url(@subcategory)
  end

  test "should not update same subcategory into other category" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    post subcategories_url, params: { subcategory: { category_id: categories(:one).id, subcategory: "Subcategory1" } }
    assert_redirected_to subcategory_url(Subcategory.last)
    post subcategories_url, params: { subcategory: { category_id: categories(:two).id, subcategory: "Subcategory2" } }
    assert_redirected_to subcategory_url(Subcategory.last)
    subcategory = Subcategory.last
    patch subcategory_url(subcategory), params: { subcategory: { category_id: categories(:two).id, subcategory: "Subcategory1" } }
    assert_response :unprocessable_entity
  end

  test "should destroy subcategory" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_difference('Subcategory.count', -1) do
      delete subcategory_url(@subcategory)
    end
    assert_redirected_to subcategories_url
  end
# End of admin section

# Ordinary user section
  test "should get index without admin links" do
    get subcategories_path
    assert_redirected_to new_user_session_url
    follow_redirect!
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    assert_redirected_to subcategories_url
    follow_redirect!
    assert_select 'h1', "Subcategories"
    assert_select 'a', count: 3 + Subcategory.count
    assert_select 'a[href="' + new_subcategory_path + '"]', count: 0
  end

  test "should not get new" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    get new_subcategory_url
    assert_redirected_to root_url
  end

  test "should not create subcategory" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Subcategory.count') do
      post subcategories_url, params: { subcategory: { category_id: @subcategory.category_id, subcategory: @other_subcategory } }
    end
    assert_redirected_to root_url
  end

  test "should show subcategory for ordinary user" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    get subcategory_url(@subcategory)
    assert_response :success
  end

  test "should not get edit" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    get edit_subcategory_url(@subcategory)
    assert_redirected_to root_url
  end

  test "should not update subcategory" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    patch subcategory_url(@subcategory), params: { subcategory: { category_id: @subcategory.category_id, subcategory: @other_subcategory } }
    assert_redirected_to root_url
  end

  test "should not destroy subcategory" do
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Subcategory.count') do
      delete subcategory_url(@subcategory)
    end
    assert_redirected_to root_url
  end
# End of ordinary user section

end