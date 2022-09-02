# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:andrey)
    @user = users(:john)
    @category = categories(:one)
    @attrs = {
      name: Faker::Lorem.word
    }
  end

  test 'admin should get index' do
    sign_in @admin
    get admin_categories_path

    assert_response :success
  end

  test 'user should not get index' do
    sign_in @user
    get admin_categories_path

    assert_redirected_to root_path
  end

  test 'admin should get new' do
    sign_in @admin
    get new_admin_category_path

    assert_response :success
  end

  test 'user should not get new' do
    sign_in @user
    get new_admin_category_path

    assert_redirected_to root_path
  end

  test 'admin can created category' do
    sign_in @admin
    post admin_categories_path, params: { category: @attrs }
    new_category = Category.find_by(@attrs)

    assert_redirected_to admin_categories_path
    assert(new_category)
  end

  test 'user can not create category' do
    sign_in @user
    post admin_categories_path, params: { category: @attrs }
    new_category = Category.find_by(@attrs)

    assert_redirected_to root_path
    assert_not(new_category)
  end

  test 'admin should get edit' do
    sign_in @admin
    get edit_admin_category_path(@category)

    assert_response :success
  end

  test 'user should not get edit' do
    sign_in @user
    get edit_admin_category_path(@category)

    assert_redirected_to root_path
  end

  test 'admin can update category' do
    sign_in @admin
    patch admin_category_path(@category), params: { category: @attrs }
    update_category = Category.find_by(@attrs)
    @category.reload

    assert_redirected_to admin_categories_path
    assert(update_category.name == @attrs[:name])
  end

  test 'user can not update category' do
    sign_in @user
    patch admin_category_path(@category), params: { category: @attrs }
    @category.reload

    assert_redirected_to root_path
    assert_not(@category.name == @attrs[:name])
  end

  test 'admin can destroy category' do
    sign_in @admin
    delete admin_category_path(@category)

    assert_redirected_to admin_categories_path
    assert_not(Category.find_by(name: @category.name))
  end

  test 'user can not destroy category' do
    sign_in @user
    delete admin_category_path(@category)
    @category.reload

    assert_redirected_to root_path
    assert(@category)
  end
end
