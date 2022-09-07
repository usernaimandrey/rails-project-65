# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    admin = users(:admin)
    sign_in admin
    get admin_root_path

    assert_response :success
  end

  test 'user should not get index' do
    user = users(:user)
    sign_in user
    get admin_root_path

    assert_response :redirect
    assert_redirected_to root_path
  end
end
