# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def update?
    user&.admin || record.user == user
  end

  def destroy?
    user&.admin
  end
end
