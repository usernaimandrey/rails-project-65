# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :user
  belongs_to :category

  validates :title, :description, presence: true
  validates :title, length: { minimum: 3, maximum: 50 }
  validates :description, length: { maximum: 1000 }

  validates :image,
            attached: true,
            content_type: %i[png jpg jpeg],
            size: { less_than: 5.megabytes }

  aasm column: :state, whiny_transitions: false do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :on_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end
end
