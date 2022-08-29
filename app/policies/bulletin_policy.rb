# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    user&.admin? || record.user == user
  end

  def destroy?
    user&.admin?
  end

  def on_moderate?
    user && record.draft?
  end

  def archive?
    user && !record.archived?
  end
end
