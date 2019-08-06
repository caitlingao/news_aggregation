class Section < ApplicationRecord
  has_many :nodes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  default_scope -> { order(sort: :desc) }

  form_select :name
end
