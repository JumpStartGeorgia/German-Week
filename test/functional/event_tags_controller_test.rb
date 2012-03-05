require 'test_helper'

class EventTagsControllerTest < ActionController::TestCase
  setup do
    @event_tag = event_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_tag" do
    assert_difference('EventTag.count') do
      post :create, :event_tag => @event_tag.attributes
    end

    assert_redirected_to event_tag_path(assigns(:event_tag))
  end

  test "should show event_tag" do
    get :show, :id => @event_tag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @event_tag.to_param
    assert_response :success
  end

  test "should update event_tag" do
    put :update, :id => @event_tag.to_param, :event_tag => @event_tag.attributes
    assert_redirected_to event_tag_path(assigns(:event_tag))
  end

  test "should destroy event_tag" do
    assert_difference('EventTag.count', -1) do
      delete :destroy, :id => @event_tag.to_param
    end

    assert_redirected_to event_tags_path
  end
end
