# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy
  has_many :favorites, class_name: 'Favorite', dependent: :destroy
  has_many :favorite_bulletins, through: :favorites, source: :bulletin

  validates :email, :name, presence: true
  validates :email, uniqueness: true
end
