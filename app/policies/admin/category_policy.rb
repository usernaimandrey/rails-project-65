# frozen_string_literal: true

module Admin
  class CategoryPolicy < ApplicationPolicy
    def index
      user&.admin?
    end
  end
end
