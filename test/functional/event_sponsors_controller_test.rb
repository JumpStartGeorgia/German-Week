require 'test_helper'

class EventSponsorsControllerTest < ActionController::TestCase
  setup do
    @event_sponsor = event_sponsors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_sponsors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_sponsor" do
    assert_difference('EventSponsor.count') do
      post :create, :event_sponsor => @event_sponsor.attributes
    end

    assert_redirected_to event_sponsor_path(assigns(:event_sponsor))
  end

  test "should show event_sponsor" do
    get :show, :id => @event_sponsor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @event_sponsor.to_param
    assert_response :success
  end

  test "should update event_sponsor" do
    put :update, :id => @event_sponsor.to_param, :event_sponsor => @event_sponsor.attributes
    assert_redirected_to event_sponsor_path(assigns(:event_sponsor))
  end

  test "should destroy event_sponsor" do
    assert_difference('EventSponsor.count', -1) do
      delete :destroy, :id => @event_sponsor.to_param
    end

    assert_redirected_to event_sponsors_path
  end
end
