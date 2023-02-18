# frozen_string_literal: true

class Web::Bulletins::FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
    @admin = users(:admin)
  end

  test '#create' do
    sign_in @admin
    bulletin = bulletins(:no_favorite)

    post bulletin_favorites_path(bulletin)
    favorite = @admin.favorite_bulletins.find_by(id: bulletin.id)

    assert { favorite }
    assert_redirected_to root_path
  end

  test '#destroy' do
    sign_in @user
    bulletin = bulletins(:published)
    favorite = favorites(:one)

    delete bulletin_favorite_path(bulletin, favorite)

    favorite_bulletin = @user.favorite_bulletins.find_by(id: bulletin.id)

    assert { !favorite_bulletin }
    assert_redirected_to root_path
  end
end
