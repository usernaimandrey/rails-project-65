# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    user&.admin? || record.user == user
  end

  def on_moderate?
    user && record.user == user
  end

  def archive?
    user
  end
end
