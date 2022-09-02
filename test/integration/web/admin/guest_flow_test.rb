# frozen_string_literal: true

require 'test_helper'

class Web::Admin::GuestFlowsTest < ActionDispatch::IntegrationTest
  test 'guest should not get index' do
    get admin_root_path

    assert_response :redirect
  end

  test 'guest should not get category index' do
    get admin_categories_path

    assert_redirected_to root_path
  end

  test 'guest not shouls get index' do
    get admin_bulletins_path

    assert_redirected_to root_path
  end

  test 'guest should not get new' do
    get new_admin_category_path

    assert_redirected_to root_path
  end

  test 'guest can not create category' do
    attrs = {
      name: Faker::Lorem.word
    }
    post admin_categories_path, params: { category: attrs }
    new_category = Category.find_by(attrs)

    assert_redirected_to root_path
    assert_not(new_category)
  end

  test 'guest should not get edit' do
    category = categories(:one)
    get edit_admin_category_path(category)

    assert_redirected_to root_path
  end

  test 'guest can not update category' do
    attrs = {
      name: Faker::Lorem.word
    }
    category = categories(:one)
    patch admin_category_path(category), params: { category: attrs }
    category.reload

    assert_redirected_to root_path
    assert_not(category.name == attrs[:name])
  end

  test 'guest can not destroy category' do
    category = categories(:one)
    delete admin_category_path(category)
    category.reload

    assert_redirected_to root_path
    assert(category)
  end

  test 'guest can not published' do
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.under_moderation?)
  end

  test 'guest can not rejected' do
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.under_moderation?)
  end

  test 'guest can not archived bulletin' do
    bulletin = bulletins(:draft)
    assert(bulletin.draft?)
    patch archive_admin_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.draft?)
  end

  test 'guest can not destroy bulletin' do
    bulletin = bulletins(:draft)
    delete admin_bulletin_path(bulletin)
    bulletin.reload

    assert_redirected_to root_path
    assert(bulletin)
  end
end
