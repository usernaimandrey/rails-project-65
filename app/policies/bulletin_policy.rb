# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    user && record.user == user
  end

  def on_moderate?
    user && record.user == user && (record.draft? || record.rejected?)
  end

  def archive?
    user && record.user == user && !record.archived?
  end
end
