class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :lockable,
         :rememberable, :trackable, :validatable

  LOGIN_FORMAT              = 'A-Za-z0-9\-\_\.'

  # @example.com 的可以修改邮件地址
  def email_locked?
    self.email.exclude?("@example.com")
  end
end
