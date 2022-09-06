# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def current_title(page_title = '')
    base_title = t('.title')
    page_title.present? ? "#{base_title} | #{page_title}" : base_title
  end

  def nav_tab(text, path, options = {})
    css_class = if current_page?(options[:current])
                  "#{options[:class]} #{options[:active]}"
                else
                  "#{options[:class]} #{options[:passive]}"
                end

    link_to text, path, class: css_class
  end

  def transfer_current_page
    return admin_root_path if current_page?(admin_root_path)

    return admin_categories_path if current_page?(admin_categories_path)

    admin_bulletins_path
  end
end
