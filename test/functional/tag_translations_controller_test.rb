require 'test_helper'

class TagTranslationsControllerTest < ActionController::TestCase
  setup do
    @tag_translation = tag_translations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tag_translations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tag_translation" do
    assert_difference('TagTranslation.count') do
      post :create, :tag_translation => @tag_translation.attributes
    end

    assert_redirected_to tag_translation_path(assigns(:tag_translation))
  end

  test "should show tag_translation" do
    get :show, :id => @tag_translation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tag_translation.to_param
    assert_response :success
  end

  test "should update tag_translation" do
    put :update, :id => @tag_translation.to_param, :tag_translation => @tag_translation.attributes
    assert_redirected_to tag_translation_path(assigns(:tag_translation))
  end

  test "should destroy tag_translation" do
    assert_difference('TagTranslation.count', -1) do
      delete :destroy, :id => @tag_translation.to_param
    end

    assert_redirected_to tag_translations_path
  end
end
