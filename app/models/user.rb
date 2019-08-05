class User < ApplicationRecord
  LOGIN_FORMAT              = 'A-Za-z0-9\-\_\.'
  ALLOW_LOGIN_FORMAT_REGEXP = /\A[#{LOGIN_FORMAT}]+\z/

  ACCESSABLE_ATTRS = %i[name email avatar current_password password password_confirmation]

  devise :database_authenticatable, :registerable, :recoverable, :lockable,
         :rememberable, :trackable, :validatable

  # has_many :topics, dependent: :destroy
  # has_many :photos

  enum state: { deleted: -1, normal: 1, blocked: 2 }
  validates :name, length: { maximum: 20 }

  def self.current
    Thread.current[:current_user]
  end

  def self.current=(user)
    Thread.current[:current_user] = user
  end

  def fullname
    name
  end

  def letter_avatar_url(size)
    path = LetterAvatar.generate(self.name, size).sub("public/", "/")

    "#{Setting.base_url}#{path}"
  end

  def large_avatar_url
    if self[:avatar].present?
      self.avatar.url(:lg)
    else
      self.letter_avatar_url(192)
    end
  end

  def avatar?
    self[:avatar].present?
  end
end
