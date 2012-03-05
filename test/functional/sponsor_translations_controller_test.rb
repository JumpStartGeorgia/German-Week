require 'test_helper'

class SponsorTranslationsControllerTest < ActionController::TestCase
  setup do
    @sponsor_translation = sponsor_translations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsor_translations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsor_translation" do
    assert_difference('SponsorTranslation.count') do
      post :create, :sponsor_translation => @sponsor_translation.attributes
    end

    assert_redirected_to sponsor_translation_path(assigns(:sponsor_translation))
  end

  test "should show sponsor_translation" do
    get :show, :id => @sponsor_translation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sponsor_translation.to_param
    assert_response :success
  end

  test "should update sponsor_translation" do
    put :update, :id => @sponsor_translation.to_param, :sponsor_translation => @sponsor_translation.attributes
    assert_redirected_to sponsor_translation_path(assigns(:sponsor_translation))
  end

  test "should destroy sponsor_translation" do
    assert_difference('SponsorTranslation.count', -1) do
      delete :destroy, :id => @sponsor_translation.to_param
    end

    assert_redirected_to sponsor_translations_path
  end
end
