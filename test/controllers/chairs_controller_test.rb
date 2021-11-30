require "test_helper"

class ChairsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chair = chairs(:one)
    @other_chair = "ChairOther"
  end

  test "should get index" do
    get chairs_url
    assert_response :success
  end

  test "should get new" do
    get new_chair_url
    assert_response :success
  end

  test "should create chair" do

    assert_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @other_chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    end

    assert_redirected_to chair_url(Chair.last)
  end

  test "should not create same chair" do
    assert_no_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @chair.chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    end

    assert_response :unprocessable_entity
  end

  test "should not create zero-price chair" do
    assert_no_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @other_chair, price: 0.00, subcategory_id: @chair.subcategory_id } }
    end

    assert_response :unprocessable_entity
  end

  test "should not create negative-price chair" do
    assert_no_difference('Chair.count') do
      post chairs_url, params: { chair: { chair: @other_chair, price: -0.01, subcategory_id: @chair.subcategory_id } }
    end

    assert_response :unprocessable_entity
  end

  test "should show chair" do
    get chair_url(@chair)
    assert_response :success
  end

  test "should get edit" do
    get edit_chair_url(@chair)
    assert_response :success
  end

  test "should update chair" do
    patch chair_url(@chair), params: { chair: { chair: @other_chair, price: @chair.price, subcategory_id: @chair.subcategory_id } }
    assert_redirected_to chair_url(@chair)
  end

  test "should not update same chair into other subcategory" do
    post chairs_url, params: { chair: { subcategory_id: subcategories(:one).id, chair: "Chair1", price: 100 } }
    assert_redirected_to chair_url(Chair.last)
    post chairs_url, params: { chair: { subcategory_id: subcategories(:one).id, chair: "Chair2", price: 200 } }
    assert_redirected_to chair_url(Chair.last)
    chair = Chair.last
    patch chair_url(chair), params: { chair: { subcategory_id: subcategories(:two).id, chair: "Chair1", price: 100 } }
    assert_response :unprocessable_entity
  end

  test "should destroy chair" do
    assert_difference('Chair.count', -1) do
      delete chair_url(@chair)
    end

    assert_redirected_to chairs_url
  end
end
