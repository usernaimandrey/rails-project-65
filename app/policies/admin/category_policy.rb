# frozen_string_literal: true

module Admin
  class CategoryPolicy < ApplicationPolicy
    def index?
      user&.admin?
    end

    def create?
      user&.admin?
    end

    def update?
      user&.admin?
    end

    def destroy?
      user&.admin? && record.bulletins.blank?
    end
  end
end
