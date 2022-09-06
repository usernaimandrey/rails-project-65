# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || author? || user&.admin?
  end

  def update?
    author?
  end

  def to_moderation?
    author?
  end

  def archive?
    author?
  end
end
