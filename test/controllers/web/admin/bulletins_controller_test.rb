# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:andrey)
    @user = users(:john)
    @bulletin = bulletins(:draft)
  end

  test 'admin shouls get index' do
    sign_in @admin
    get admin_bulletins_path

    assert_response :success
  end

  test 'user not shouls get index' do
    sign_in @user
    get admin_bulletins_path

    assert_redirected_to root_path
  end

  test 'admin can destroy bulletin' do
    sign_in @admin
    delete admin_bulletin_path(@bulletin)

    assert_redirected_to admin_bulletins_path
    assert_not(Bulletin.find_by(id: @bulletin.id))
  end

  test 'user can not destroy bulletin' do
    sign_in @user
    delete admin_bulletin_path(@bulletin)
    @bulletin.reload

    assert_redirected_to root_path
    assert(@bulletin)
  end

  test 'admin can rejected' do
    sign_in @admin
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.rejected?)
  end

  test 'user can not rejected' do
    sign_in @user
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.under_moderation?)
  end

  test 'admin can published' do
    sign_in @admin
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.published?)
  end

  test 'user can not published' do
    sign_in @user
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.under_moderation?)
  end

  test 'refute rejected on published' do
    sign_in @admin
    bulletin = bulletins(:published)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.published?)
  end

  test 'refute published on archive' do
    sign_in @admin
    bulletin = bulletins(:archived)
    patch publish_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.archived?)
  end

  test 'refute rejected on archive' do
    sign_in @admin
    bulletin = bulletins(:archived)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.archived?)
  end
end
