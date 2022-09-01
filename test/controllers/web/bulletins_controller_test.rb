# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:draft)
    @user = users(:andrey)
    @attrs = {
      title: Faker::Vehicle.make,
      description: Faker::Vehicle.standard_specs.join(','),
      category_id: categories(:two).id,
      image: fixture_file_upload('img_2.png', 'image/png')
    }
  end

  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should get show' do
    get bulletin_path(@bulletin)

    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_bulletin_path

    assert_response :success
  end

  test 'guest should raise error from new' do
    get new_bulletin_path

    assert_redirected_to root_path
  end

  test 'signin user can created bulletin' do
    sign_in @user
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = @user.bulletins.find_by(title: @attrs[:title], description: @attrs[:description])

    assert(new_bulletin)
    assert_redirected_to profile_path
  end

  test 'guest can not created bulletin' do
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = @user.bulletins.find_by(title: @attrs[:title], description: @attrs[:description])

    assert_not(new_bulletin)
    assert_redirected_to root_path
  end

  test 'not created whith invalid params' do
    sign_in @user
    @attrs[:title] = Faker::Lorem.sentence(word_count: 50)
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = @user.bulletins.find_by(title: @attrs[:title], description: @attrs[:description])

    assert_not(new_bulletin)
    assert_response 422
  end

  test 'signin user should get edit' do
    sign_in @user
    get edit_bulletin_path(@bulletin)

    assert_response :success
  end

  test 'guest can not should get edit' do
    get edit_bulletin_path(@bulletin)

    assert_redirected_to root_path
  end

  test 'signin user should get update' do
    sign_in @user
    attr = { title: Faker::Lorem.sentence(word_count: 3) }
    patch bulletin_path(@bulletin), params: { bulletin: attr }
    @bulletin.reload

    assert(@bulletin.title == attr[:title])
    assert_redirected_to profile_path
  end

  test 'guest can not update bulletin' do
    attr = { title: Faker::Lorem.sentence(word_count: 3) }
    patch bulletin_path(@bulletin), params: { bulletin: attr }

    @bulletin.reload

    assert_not(@bulletin.title == attr[:title])
    assert_redirected_to root_path
  end

  test 'update with invalid params' do
    sign_in @user
    attr = { title: '' }
    patch bulletin_path(@bulletin), params: { bulletin: attr }

    @bulletin.reload

    assert_not(@bulletin.title == attr[:title])
    assert_response 422
  end

  test "non-author can't update" do
    user = users(:john)
    sign_in user

    attr = { title: Faker::Lorem.sentence(word_count: 3) }
    patch bulletin_path(@bulletin), params: { bulletin: attr }

    @bulletin.reload

    assert_not(@bulletin.title == attr[:title])
    assert_redirected_to root_path
  end

  test 'draft on moderation' do
    sign_in @user
    patch on_moderate_bulletin_path(@bulletin)
    @bulletin.reload

    assert(@bulletin.under_moderation?)
  end

  test "guest can't send on moderation" do
    patch on_moderate_bulletin_path(@bulletin)
    @bulletin.reload

    assert_not(@bulletin.under_moderation?)
    assert_redirected_to root_path
  end

  test "non-author can't send on moderation" do
    user = users(:john)
    sign_in user
    patch on_moderate_bulletin_path(@bulletin)
    @bulletin.reload

    assert_not(@bulletin.under_moderation?)
    assert_redirected_to root_path
  end

  test 'rejected on moderation' do
    sign_in @user
    bulletin = bulletins(:rejected)
    patch on_moderate_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.under_moderation?)
  end

  test 'draft on archived' do
    sign_in @user
    patch archive_bulletin_path(@bulletin)
    @bulletin.reload

    assert(@bulletin.archived?)
  end

  test 'rejected on archived' do
    sign_in @user
    bulletin = bulletins(:rejected)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.archived?)
  end

  test 'published on archived' do
    sign_in @user
    bulletin = bulletins(:published)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.archived?)
  end

  test 'under_moderation on archived' do
    user = users(:john)
    sign_in user
    bulletin = bulletins(:under_moderation)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.archived?)
  end

  test "guest can't send on archive" do
    bulletin = bulletins(:published)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.published?)
  end

  test "non-author can't send on archive" do
    user = users(:john)
    sign_in user
    bulletin = bulletins(:published)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.published?)
  end

  test 'refute under_moderated archive' do
    user = users(:john)
    sign_in user
    bulletin = bulletins(:archived)
    patch on_moderate_bulletin_path(bulletin)

    assert(bulletin.archived?)
  end

  test 'refute under_moderated published' do
    sign_in @user
    bulletin = bulletins(:published)
    patch on_moderate_bulletin_path(bulletin)

    assert(bulletin.published?)
  end
end
