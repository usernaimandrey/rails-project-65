# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @category = categories(:one)
    @attrs = {
      name: Faker::Lorem.word
    }
    sign_in @admin
  end

  test '#index' do
    get admin_categories_path

    assert_response :success
  end

  test 'user should not get index' do
    delete session_path
    user = users(:user)
    sign_in user
    get admin_categories_path

    assert_redirected_to root_path
  end

  test '#new' do
    get new_admin_category_path

    assert_response :success
  end

  test '#create' do
    post admin_categories_path, params: { category: @attrs }
    new_category = Category.find_by(@attrs)

    assert_redirected_to admin_categories_path
    assert { new_category }
  end

  test '#edit' do
    get edit_admin_category_path(@category)

    assert_response :success
  end

  test '#update' do
    sign_in @admin
    patch admin_category_path(@category), params: { category: @attrs }
    update_category = Category.find_by(@attrs)
    @category.reload

    assert_response :redirect
    assert_redirected_to admin_categories_path
    assert { update_category.name == @attrs[:name] }
  end

  test '#destroy' do
    category = categories(:no_relation)
    delete admin_category_path(category)

    assert_response :redirect
    assert_redirected_to admin_categories_path
    assert_not(Category.find_by(name: category.name))
  end

  test "can't delete a category that has a relation" do
    delete admin_category_path(@category)

    assert_response :redirect
    assert_redirected_to admin_categories_path
    assert { Category.find_by(name: @category.name) }
  end
end
