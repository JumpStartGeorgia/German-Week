require 'test_helper'

class ImageHeadersControllerTest < ActionController::TestCase
  setup do
    @image_header = image_headers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:image_headers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image_header" do
    assert_difference('ImageHeader.count') do
      post :create, image_header: @image_header.attributes
    end

    assert_redirected_to image_header_path(assigns(:image_header))
  end

  test "should show image_header" do
    get :show, id: @image_header.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @image_header.to_param
    assert_response :success
  end

  test "should update image_header" do
    put :update, id: @image_header.to_param, image_header: @image_header.attributes
    assert_redirected_to image_header_path(assigns(:image_header))
  end

  test "should destroy image_header" do
    assert_difference('ImageHeader.count', -1) do
      delete :destroy, id: @image_header.to_param
    end

    assert_redirected_to image_headers_path
  end
end
