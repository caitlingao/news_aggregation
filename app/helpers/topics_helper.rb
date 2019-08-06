# frozen_string_literal: true

require "digest/md5"
module TopicsHelper
  include LetterAvatar::AvatarHelper

  def topic_favorite_tag(topic, opts = {})
    return "" if current_user.blank?
    opts[:class] ||= ""
    class_name = ""
    link_title = "收藏"
    if current_user&.favorite_topic?(topic)
      class_name = "active"
      link_title = "取消收藏"
    end

    icon = raw(content_tag("i", "", class: "fa fa-bookmark"))
    if opts[:class].present?
      class_name += " " + opts[:class]
    end

    link_to(raw("#{icon} 收藏"), "#", title: link_title, class: "bookmark #{class_name}", "data-id" => topic.id)
  end

  def topic_follow_tag(topic, opts = {})
    return "" if current_user.blank?
    return "" if topic.blank?
    return "" if owner?(topic)
    opts[:class] ||= ""
    class_name = "follow"
    class_name += " active" if current_user.follow_topic?(topic)
    if opts[:class].present?
      class_name += " " + opts[:class]
    end
    icon = content_tag("i", "", class: "fa fa-eye")
    link_to(raw("#{icon} 关注"), "#", "data-id" => topic.id, class: class_name)
  end

  def topic_title_tag(topic, opts = {})
    return t("topics.topic_was_deleted") if topic.blank?
    if opts[:reply]
      index = topic.floor_of_reply(opts[:reply])
      path = main_app.topic_path(topic, anchor: "reply#{index}")
    else
      path = main_app.topic_path(topic)
    end
    link_to(topic.title, path, title: topic.title)
  end

  def topic_excellent_tag(topic)
    return "" unless topic.excellent?
    content_tag(:i, "", title: "精华帖", class: "fa fa-diamond", data: { toggle: "tooltip" })
  end

  def topic_close_tag(topic)
    return "" unless topic.closed?
    content_tag(:i, "", title: "问题已解决／话题已结束讨论", class: "fa fa-check", data: { toggle: "tooltip" })
  end

  def render_node_name(name, id, node_id)
    link_to(name, main_app.section_path(id, category: node_id), class: "node")
  end

  def topic_banner_tag(topic, version = :md, link: true, timestamp: nil)
    width     = topic_banner_width_for_size(version)
    img_class = "media-object banner-#{width}"

    return image_tag("banner/#{version}.png", class: img_class, width: width, height: width * 0.7) if topic.blank?

    img =
      if topic.banner?
        image_url = topic.banner.url(version)
        image_url += "?t=#{topic.updated_at.to_i}" if timestamp
        image_tag(image_url, class: img_class, width: width, height: width * 0.6)
      else
        image_tag(topic.letter_banner_url(width * 2), class: img_class, width: width, height: width * 0.6)
      end

    html_options = {}
    html_options[:title] = topic.title

    if link
      link_to(raw(img), "/#{topic.title}", html_options)
    else
      raw img
    end
  end

  def topic_banner_width_for_size(size)
    case size
      when :xs then 16
      when :sm then 32
      when :md then 48
      when :lg then 200
      when :large then 600
      else size
    end
  end
end
