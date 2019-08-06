# frozen_string_literal: true

module Admin
  class HomeController < Admin::ApplicationController
    def index
      @recent_topics = Topic.order(id: :desc).limit(5)
    end
  end
end
