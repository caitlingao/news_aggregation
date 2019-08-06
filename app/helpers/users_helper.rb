require "digest/md5"

module UsersHelper
  include LetterAvatar::AvatarHelper

  # 生成用户 login 的链接，user 参数可接受 user 对象或者 字符串的 login
  def user_name_tag(user, options = {})
    return "匿名" if user.blank?

    user_type = :user
    login     = user
    label     = login
    name      = login

    if user.is_a? User
      user_type = :user
      label     = user.name
      name      = user.name
    end

    options[:class] ||= "#{user_type}-name"
    options["data-name"] = name

    link_to(label, "/#{name}", options)
  end

  def user_avatar_width_for_size(size)
    case size
    when :xs then 16
    when :sm then 32
    when :md then 48
    when :lg then 96
    else size
    end
  end

  def user_avatar_tag(user, version = :md, link: true, timestamp: nil)
    width     = user_avatar_width_for_size(version)
    img_class = "media-object avatar-#{width}"

    return image_tag("avatar/#{version}.png", class: img_class) if user.blank?

    img =
      if user.avatar?
        image_url = user.avatar.url(version)
        image_url += "?t=#{user.updated_at.to_i}" if timestamp
        image_tag(image_url, class: img_class)
      else
        image_tag(user.letter_avatar_url(width * 2), class: img_class)
      end

    html_options = {}
    html_options[:title] = user.fullname

    if link
      link_to(raw(img), "/#{user.login}", html_options)
    else
      raw img
    end
  end
end
