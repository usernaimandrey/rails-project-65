# frozen_string_literal: true

module Admin
  class BulletinPolicy < ApplicationPolicy
    def index?
      user&.admin?
    end

    def destroy?
      user&.admin?
    end

    def archive?
      user&.admin? && !record.archived?
    end

    def publish?
      user&.admin? && record.under_moderation?
    end

    def reject?
      user&.admin? && record.under_moderation?
    end
  end
end
