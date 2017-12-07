# Questions - ask whatever you like
class Question < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  has_many :answers, dependent: :destroy

  scope :latest, -> { order(:created_at).take(10) }

  validates :title, presence: true
  validates :content, presence: true

  searchkick word_start: [:title, :content], suggest: [:title], highlight: [:title]

  def search_data
    {
      title: title,
      content: content
    }
  end

  def owner?(current_user)
    current_user == self.user
  end
end
