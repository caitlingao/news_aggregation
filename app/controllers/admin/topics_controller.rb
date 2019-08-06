# frozen_string_literal: true

module Admin
  class TopicsController < Admin::ApplicationController
    before_action :set_topic, only: %i[show edit update destroy undestroy suggest unsuggest action]

    def index
      @topics = Topic.unscoped
      if params[:q].present?
        qstr = "%#{params[:q].downcase}%"
        @topics = @topics.where("title LIKE ?", qstr)
      end
      @topics = @topics.includes(:user).order(id: :desc).page(params[:page])
    end

    def show
    end

    def new
      @topic = Topic.new
    end

    def edit
    end

    def create
      @topic = Topic.new(topic_params)
      @topic.user_id = current_user.id
      @topic.node_id = params[:node] || topic_params[:node_id]

      if @topic.save
        redirect_to(admin_topics_path, notice: "Topic was successfully created.")
      else
        render action: "new"
      end
    end

    def update
      if @topic.update(topic_params)
        redirect_to(admin_topics_path, notice: "Topic was successfully updated.")
      else
        render action: "edit"
      end
    end

    def destroy
      @topic.destroy_by(current_user)

      redirect_to(admin_topics_path)
    end

    def preview
      @body = params[:body]

      respond_to do |format|
        format.json
      end
    end

    def undestroy
      @topic.update_attribute(:deleted_at, nil)
      redirect_to(admin_topics_path)
    end

    def suggest
      @topic.update_attribute(:suggested_at, Time.now)
      redirect_to(admin_topics_path)
    end

    def unsuggest
      @topic.update_attribute(:suggested_at, nil)
      redirect_to(admin_topics_path)
    end

    def action
      case params[:type]
      when "excellent"
        @topic.excellent!
        redirect_to admin_topics_path, notice: "加精成功。"
      when "normal"
        @topic.normal!
        redirect_to admin_topics_path, notice: "话题已恢复到普通评级。"
      when "ban"
        params[:reason_text] ||= params[:reason] || ""
        @topic.ban!(reason: params[:reason_text].strip)
        redirect_to admin_topic_path, notice: "话题已放进屏蔽栏目。"
      when "close"
        @topic.close!
        redirect_to admin_topic_path, notice: "话题已关闭，将不再接受任何新的回复。"
      when "open"
        @topic.open!
        redirect_to admin_topic_path, notice: "话题已重启开启。"
      end
    end

    private

    def set_topic
      @topic = Topic.unscoped.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :body, :node_id, :sort, :summary, :banner)
    end
  end
end
