# frozen_string_literal: true

require 'test_helper'

class Web::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'signin user should get profile' do
    user = users(:andrey)
    sign_in user
    get profile_path

    assert_response :success
  end

  test 'guest can not get profile' do
    get profile_path

    assert_response :redirect
  end
end
