require "test_helper"

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subcategory = subcategories(:one)
    @other_subcategory = "OtherSubcategory"
  end

  test "should get index" do
    get subcategories_url
    assert_response :success
  end

  test "should get new" do
    get new_subcategory_url
    assert_response :success
  end

  test "should create subcategory" do
    assert_difference('Subcategory.count') do
      post subcategories_url, params: { subcategory: { category_id: @subcategory.category_id, subcategory: @other_subcategory } }
    end
    assert_redirected_to subcategory_url(Subcategory.last)
  end

  test "should not create same subcategory" do
    assert_no_difference('Subcategory.count') do
      post subcategories_url, params: { subcategory: { category_id: @subcategory.category_id, subcategory: @subcategory.subcategory } }
    end
    assert_response :unprocessable_entity
  end

  test "should show subcategory" do
    get subcategory_url(@subcategory)
    assert_response :success
  end

  test "should get edit" do
    get edit_subcategory_url(@subcategory)
    assert_response :success
  end

  test "should update subcategory" do
    patch subcategory_url(@subcategory), params: { subcategory: { category_id: @subcategory.category_id, subcategory: @other_subcategory } }
    assert_redirected_to subcategory_url(@subcategory)
  end

  test "should not update same subcategory into other category" do
    post subcategories_url, params: { subcategory: { category_id: categories(:one).id, subcategory: "Subcategory1" } }
    assert_redirected_to subcategory_url(Subcategory.last)
    post subcategories_url, params: { subcategory: { category_id: categories(:two).id, subcategory: "Subcategory2" } }
    assert_redirected_to subcategory_url(Subcategory.last)
    subcategory = Subcategory.last
    patch subcategory_url(subcategory), params: { subcategory: { category_id: categories(:two).id, subcategory: "Subcategory1" } }
    assert_response :unprocessable_entity
  end

  test "should destroy subcategory" do
    assert_difference('Subcategory.count', -1) do
      delete subcategory_url(@subcategory)
    end
    assert_redirected_to subcategories_url
  end
end
