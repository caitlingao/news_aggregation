# frozen_string_literal: true

class TopicsController < ApplicationController
  def show
    @topic = Topic.unscoped.includes(:user).find(params[:id])
    render_404 if @topic.deleted?
  end

  private

    def set_topic
      @topic ||= Topic.find(params[:id])
    end
end
