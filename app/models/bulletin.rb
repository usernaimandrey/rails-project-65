# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, :description, presence: true
  validates :title, length: { minimum: 3, maximum: 50 }
  validates :description, length: { maximum: 1000 }
end
