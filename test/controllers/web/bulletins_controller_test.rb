# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @draft = bulletins(:draft)
    @rejected = bulletins(:rejected)
    @published = bulletins(:published)
    @admin = users(:andrey)
    @user = users(:john)
    @attrs = {
      title: Faker::Vehicle.make,
      description: Faker::Vehicle.standard_specs.join(','),
      category_id: categories(:two).id,
      image: fixture_file_upload('img_2.png', 'image/png')
    }
    sign_in @admin
  end

  test 'should get index' do
    get bulletins_path

    assert_response :success
  end

  test 'should get show' do
    get bulletin_path(@draft)

    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_path

    assert_response :success
  end

  test 'signin user can created bulletin' do
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = @admin.bulletins.find_by(title: @attrs[:title], description: @attrs[:description])

    assert(new_bulletin)
    assert_redirected_to profile_path
  end

  test 'not created whith invalid params' do
    @attrs[:title] = Faker::Lorem.sentence(word_count: 50)
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = @user.bulletins.find_by(title: @attrs[:title], description: @attrs[:description])

    assert_not(new_bulletin)
    assert_response 422
  end

  test 'signin user should get update' do
    attr = { title: Faker::Lorem.sentence(word_count: 3) }
    patch bulletin_path(@draft), params: { bulletin: attr }
    @draft.reload

    assert(@draft.title == attr[:title])
    assert_redirected_to profile_path
  end

  test 'update with invalid params' do
    attr = { title: '' }
    patch bulletin_path(@draft), params: { bulletin: attr }
    @draft.reload

    assert_not(@draft.title == attr[:title])
    assert_response 422
  end

  test 'draft on moderation' do
    patch to_moderation_bulletin_path(@draft)
    @draft.reload

    assert(@draft.under_moderation?)
  end

  test 'rejected on moderation' do
    patch to_moderation_bulletin_path(@rejected)
    @rejected.reload

    assert(@rejected.under_moderation?)
  end

  test 'draft on archived' do
    patch archive_bulletin_path(@draft)
    @draft.reload

    assert(@draft.archived?)
  end

  test 'rejected on archived' do
    patch archive_bulletin_path(@rejected)
    @rejected.reload

    assert(@rejected.archived?)
  end

  test 'published on archived' do
    patch archive_bulletin_path(@published)
    @published.reload

    assert(@published.archived?)
  end

  test 'under_moderation on archived' do
    delete session_path
    sign_in @user
    bulletin = bulletins(:under_moderation)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.archived?)
  end

  test 'refute under_moderated archive' do
    delete session_path
    sign_in @user
    bulletin = bulletins(:archived)
    patch to_moderation_bulletin_path(bulletin)

    assert(bulletin.archived?)
  end

  test 'refute under_moderated published' do
    patch to_moderation_bulletin_path(@published)
    @published.reload

    assert(@published.published?)
  end
end
