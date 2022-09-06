# frozen_string_literal: true

module Admin
  class CategoryPolicy < ApplicationPolicy
    def destroy?
      record.bulletins.blank?
    end
  end
end
