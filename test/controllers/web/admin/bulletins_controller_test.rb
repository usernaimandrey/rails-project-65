# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @draft = bulletins(:draft)
    sign_in @admin
  end

  test '#index' do
    get admin_bulletins_path

    assert_response :success
  end

  test 'user not should get index' do
    delete session_path
    user = users(:user)
    sign_in user
    get admin_bulletins_path

    assert_redirected_to root_path
  end

  test '#destroy' do
    delete admin_bulletin_path(@draft)

    assert_redirected_to admin_bulletins_path
    assert_not(Bulletin.find_by(id: @draft.id))
  end

  test '#reject' do
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload

    assert_redirected_to admin_root_path
    assert { bulletin.rejected? }
  end

  test '#publish' do
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_path(bulletin)
    bulletin.reload

    assert_redirected_to admin_root_path
    assert { bulletin.published? }
  end

  test '#archive' do
    patch archive_admin_bulletin_path(@draft)
    @draft.reload

    assert_redirected_to admin_bulletins_path
    assert { @draft.archived? }
  end

  test 'refute rejected on published' do
    bulletin = bulletins(:published)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload

    assert_response 422
    assert { bulletin.published? }
  end
end
