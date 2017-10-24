class Question < ApplicationRecord
  scope :latest, -> { order(:created_at).take(10) }

  validates :title, presence: true

  searchkick text_start: [:title], suggest: [:title]
end
