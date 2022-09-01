# frozen_string_literal: true

module AdminConcern
  def current_page
    page = request&.referer&.split('/')&.last

    return admin_bulletins_path if page == 'bulletins'

    admin_root_path
  end
end
