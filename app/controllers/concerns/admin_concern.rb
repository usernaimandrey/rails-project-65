# frozen_string_literal: true

module AdminConcern
  def current_page
    page = params[:controller].split('/').last

    return admin_bulletins_path if page == 'bulletins'

    return admin_categories_path if page == 'categories'

    admin_root_path
  end
end
