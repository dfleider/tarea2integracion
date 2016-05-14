require 'test_helper'
require 'coveralls'
Coveralls.wear!


class InstagramControllerTest < ActionController::TestCase
  test "should get inicio" do
    get :welcome
    assert_response :success
  end

  test "falta de parametros" do
  	post :inicio
  	assert_response 400
  end

  test "con parametros correctos" do
  	post :inicio , tag: "chile" , access_token: "2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"
  	assert_response 200
  end

end
