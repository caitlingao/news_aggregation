# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def password
  end

  def update
    case params[:by]
    when "password"
      update_password
    else
      update_basic
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      attrs = User::ACCESSABLE_ATTRS.dup

      params.require(:user).permit(*attrs)
    end

    def update_basic
      if @user.update(user_params)
        redirect_to setting_path, notice: "更新成功"
      else
        render "show"
      end
    end

    def update_password
      if @user.update_with_password(user_params)
        redirect_to new_session_path(:user), notice: "密码更新成功，现在你需要重新登陆。"
      else
        render "password"
      end
    end
end
