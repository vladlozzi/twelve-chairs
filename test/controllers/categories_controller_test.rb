require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @other_category = "CategoryOther"
  end

  test "should get index" do
    get categories_path
    assert_redirected_to new_user_session_url
    follow_redirect!
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    assert_redirected_to categories_url
    follow_redirect!
    assert_select 'h1', "Categories"
    assert_select 'a', count: 3 + Category.count * 3
    assert_select 'a[href="' + new_category_path + '"]'
  end

  test "should get new" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get new_category_path
    assert_response :success
    assert_select 'h1', "New Category"
    assert_select 'input[type=submit]'
    assert_select 'a[href="' + categories_path + '"]'
  end

  test "should create category" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_difference('Category.count') do
      post categories_path, params: { category: { category: @other_category } }
    end
    assert_redirected_to category_url(Category.last)
  end

  test "should not create the same category" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_no_difference('Category.count') do
      post categories_path, params: { category: { category: @category.category } }
    end
    assert_response :unprocessable_entity
  end

  test "should show category" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get category_path(@category)
    assert_response :success
  end

  test "should get edit" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    get edit_category_path(@category)
    assert_response :success
  end

  test "should update category" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    patch category_path(@category), params: { category: { category: @other_category } }
    assert_redirected_to category_url(@category)
  end

  test "should destroy category" do
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    follow_redirect!
    assert_difference('Category.count', -1) do
      delete category_path(@category)
    end
    assert_redirected_to categories_url
  end
end
