# frozen_string_literal: true

require 'test_helper'

class Web::SessionsControllerTest < ActionDispatch::IntegrationTest
  test '#destroy' do
    user = users(:john)
    sign_in user

    assert(signed_in?)

    delete session_path

    assert_not(signed_in?)
    assert_response :redirect
  end
end
