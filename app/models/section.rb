class Section < ApplicationRecord
  acts_as_paranoid
  second_level_cache expires_in: 2.weeks

  has_many :nodes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  default_scope -> { order(sort: :desc) }

  form_select :name
end
