# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_active_menu

    def require_admin
      render_404 unless current_user.admin?
    end

    def set_active_menu
      @current = ["/" + ["admin", controller_name].join("/")]
    end

    def markdown(text)
      return nil if text.blank?
      Rails.cache.fetch(["markdown", "v1", Digest::MD5.hexdigest(text)]) do
        sanitize_markdown(Homeland::Markdown.call(text))
      end
    end

    def sanitize_markdown(html)
      raw Sanitize.fragment(html, Homeland::Sanitize::DEFAULT)
    end
  end
end
