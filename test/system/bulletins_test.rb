# frozen_string_literal: true

require 'application_system_test_case'

class BulletinsTest < ApplicationSystemTestCase
  setup do
    @admin = users(:andrey)
  end

  test 'filter is working' do
    # visit root_path

    # fill_in 'q_title_cont',	with: 'Ботинки'
    # click_on 'Найти'

    # found_bulletins = all('img')

    # assert(found_bulletins.count == 1)
  end
end
