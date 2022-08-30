# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :email, :name, presence: true
  validates :email, uniqueness: true
end
