# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test '#show' do
    user = users(:user)
    sign_in user
    get profile_path

    assert_response :success
  end

  test 'guest can not get profile' do
    get profile_path

    assert_response :redirect
    assert_redirected_to root_path
  end
end
