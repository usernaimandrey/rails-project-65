# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def current_title(page_title = '')
    base_title = t('.title')
    page_title.present? ? "#{base_title} | #{page_title}" : base_title
  end
end
