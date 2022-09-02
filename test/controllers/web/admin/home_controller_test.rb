# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  test 'admin should get index' do
    admin = users(:andrey)
    sign_in admin
    get admin_root_path

    assert_response :success
  end

  test 'user should not get index' do
    user = users(:john)
    sign_in user
    get admin_root_path

    assert_response :redirect
  end
end
