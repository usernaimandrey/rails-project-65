# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @draft = bulletins(:draft)
    @user = users(:user)
    @attrs = {
      title: Faker::Vehicle.make,
      description: Faker::Vehicle.standard_specs.join(','),
      category_id: categories(:two).id,
      image: fixture_file_upload('img_2.png', 'image/png')
    }
    sign_in @user
  end

  test '#index' do
    get bulletins_path

    assert_response :success
  end

  test '#show' do
    get bulletin_path(@draft)

    assert_response :success
  end

  test '#new' do
    get new_bulletin_path

    assert_response :success
  end

  test 'guest can not get new' do
    delete session_path
    get new_bulletin_path

    assert_response :redirect
    assert_redirected_to root_path
  end

  test '#create' do
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = @user.bulletins.find_by(@attrs.except(:image))

    assert { new_bulletin }
    assert_response :redirect
    assert_redirected_to profile_path
  end

  test 'not created whith invalid params' do
    @attrs[:title] = Faker::Lorem.sentence(word_count: 50)
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = @user.bulletins.find_by(@attrs.except(:image))

    assert_not(new_bulletin)
    assert_response 422
  end

  test '#edit' do
    get edit_bulletin_path(@draft)

    assert_response :success
  end

  test '#update' do
    attr = { title: Faker::Lorem.sentence(word_count: 3) }
    patch bulletin_path(@draft), params: { bulletin: attr }
    @draft.reload

    assert { @draft.title == attr[:title] }
    assert_response :redirect
    assert_redirected_to profile_path
  end

  test 'not update with invalid params' do
    attr = { title: '' }
    patch bulletin_path(@draft), params: { bulletin: attr }
    @draft.reload

    assert_not(@draft.title == attr[:title])
    assert_response 422
  end

  test 'update bulletin only author' do
    bulletin = bulletins(:published)
    assert { bulletin.user.name == 'Andrey' }
    assert { current_user.name == 'John' }

    attr = { title: Faker::Lorem.sentence(word_count: 3) }
    patch bulletin_path(bulletin), params: { bulletin: attr }

    assert_not(bulletin.title == attr[:title])
    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'draft on moderation' do
    patch to_moderation_bulletin_path(@draft)
    @draft.reload

    assert_response :redirect
    assert_redirected_to profile_path
    assert { @draft.under_moderation? }
  end

  test 'refute under_moderated archive' do
    bulletin = bulletins(:archived)
    patch to_moderation_bulletin_path(bulletin)

    assert_response 422
    assert { bulletin.archived? }
  end
end
