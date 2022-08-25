# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def current_title(page_title = '')
    base_title = t('.title')
    page_title.present? ? "#{base_title} | #{page_title}" : base_title
  end

  def formatted_time_creation(to_time)
    from_time = Time.current
    distance_of_time_in_words(from_time, to_time)
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page

    css_class = current_page == title ? 'text-primary' : 'text-secondary'

    options[:class] = if options[:class]
                        "#{options[:class]} #{css_class}"
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'layouts/shared/nav', locals: { current_page: current_page }
  end
end
