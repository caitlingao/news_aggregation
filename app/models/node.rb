class Node < ApplicationRecord
  acts_as_paranoid
  second_level_cache expires_in: 2.weeks

  delegate :name, to: :section, prefix: true, allow_nil: true

  has_many :topics
  belongs_to :section, optional: true

  validates :name, :summary, :section, presence: true
  validates :name, uniqueness: true

  scope :sorted, -> { order(sort: :desc) }

  form_select :name
end
