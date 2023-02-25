# frozen_string_literal: true

module Bulletins
  class FavoritePolicy < ApplicationPolicy
    def create?
      record.bulletin.user != user
    end
  end
end
