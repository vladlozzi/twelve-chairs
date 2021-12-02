require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
    assert_select 'a[href="' + new_user_session_path + '"]', "Вхід"
    assert_select 'a[href="' + new_user_registration_path + '"]', "Реєстрація"
  end

  test "should signed in as admin and signed out" do
    get new_user_session_path
    assert_response :success
    assert_select 'input[type=submit]'
    post user_session_path, params: { user: { email: "admin@example.com", password: "secret" } }
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'h3', 'Панель адміністратора'
    assert_select 'a[href="' + categories_path + '"]', 'Категорії товарів'
    assert_select 'a[href="' + subcategories_path + '"]', 'Підкатегорії товарів'
    assert_select 'a[href="' + chairs_path + '"]', 'Перелік товарів'
    delete destroy_user_session_path
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href="' + new_user_session_path + '"]', "Вхід"
    assert_select 'a[href="' + new_user_registration_path + '"]', "Реєстрація"
  end

  test "should signed in as ordinary user and signed out" do
    get new_user_session_path
    assert_response :success
    assert_select 'input[type=submit]'
    post user_session_path, params: { user: { email: "user@example.com", password: "secret" } }
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'h3', 'Ласкаво просимо!'
    assert_select 'a[href="' + categories_path + '"]', 'Категорії товарів'
    assert_select 'a[href="' + subcategories_path + '"]', count: 0
    assert_select 'a[href="' + chairs_path + '"]', count: 0
    delete destroy_user_session_path
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href="' + new_user_session_path + '"]', "Вхід"
    assert_select 'a[href="' + new_user_registration_path + '"]', "Реєстрація"
  end
end
