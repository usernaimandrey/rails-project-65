# frozen_string_literal: true

module Admin
  class BulletinPolicy < ApplicationPolicy
    def index
      user&.admin?
    end
  end
end
