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
      user&.admin?
    end

    def publish?
      user&.admin?
    end

    def reject?
      user&.admin?
    end
  end
end
