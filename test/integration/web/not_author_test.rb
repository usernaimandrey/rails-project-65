# frozen_string_literal: true

require 'test_helper'

class Web::NotAuthorTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:draft)
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

  test "non-author can't send on moderation" do
    user = users(:john)
    sign_in user
    patch to_moderation_bulletin_path(@bulletin)
    @bulletin.reload

    assert_not(@bulletin.under_moderation?)
    assert_redirected_to root_path
  end

  test "non-author can't send on archive" do
    user = users(:john)
    sign_in user
    bulletin = bulletins(:published)
    patch archive_bulletin_path(bulletin)
    bulletin.reload

    assert(bulletin.published?)
    assert_redirected_to root_path
  end
end
