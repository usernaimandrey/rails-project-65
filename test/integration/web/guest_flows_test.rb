# frozen_string_literal: true

require 'test_helper'

class Web::GuestFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:draft)
    @attrs = {
      title: Faker::Vehicle.make,
      description: Faker::Vehicle.standard_specs.join(','),
      category_id: categories(:two).id,
      image: fixture_file_upload('img_2.png', 'image/png')
    }
  end

  test 'get show only published bulletin' do
    get bulletin_path(@bulletin)

    assert_redirected_to root_path
  end

  test 'guest not should get new' do
    get new_bulletin_path

    assert_redirected_to root_path
  end

  test 'guest can not created bulletin' do
    post bulletins_path, params: { bulletin: @attrs }
    new_bulletin = Bulletin.find_by(title: @attrs[:title], description: @attrs[:description])

    assert_not(new_bulletin)
    assert_redirected_to root_path
  end

  test 'guest can not should get edit' do
    get edit_bulletin_path(@bulletin)

    assert_redirected_to root_path
  end

  test 'guest can not update bulletin' do
    attr = { title: Faker::Lorem.sentence(word_count: 3) }
    patch bulletin_path(@bulletin), params: { bulletin: attr }

    @bulletin.reload

    assert_not(@bulletin.title == attr[:title])
    assert_redirected_to root_path
  end

  test "guest can't send on moderation" do
    patch on_moderate_bulletin_path(@bulletin)
    @bulletin.reload

    assert_not(@bulletin.under_moderation?)
    assert_redirected_to root_path
  end

  test "guest can't send on archive" do
    bulletin = bulletins(:published)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.published?)
    assert_redirected_to root_path
  end
end
