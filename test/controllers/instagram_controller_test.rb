require 'test_helper'

class InstagramControllerTest < ActionController::TestCase
  test "should get inicio" do
    get :inicio
    assert_response :success
  end

  test "falta de parametros" do
  	post :inicio
  	assert_response 400
  end

end
