# frozen_string_literal: true

module Admin
  class PhotosController < Admin::ApplicationController
    before_action :set_photo, only: %i[show destroy]

    def index
      @photos = Photo.order(id: :desc).includes(:user).page(params[:page])
    end

    def create
      # 浮动窗口上传
      @photo = Photo.new
      @photo.image = params[:file]
      if @photo.image.blank?
        render json: { ok: false }, status: 400
        return
      end

      @photo.user_id = current_user.id
      if @photo.save
        render json: { ok: true, url: @photo.image.url(:large) }
      else
        render json: { ok: false }
      end
    end

    def destroy
      @photo.destroy
      redirect_to(admin_photos_url)
    end

    private

      def set_photo
        @photo = Photo.find(params[:id])
      end
  end
end
