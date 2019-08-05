# frozen_string_literal: true

class UsersController < ApplicationController
  def show
  end

  protected

    def set_user
      @user = User.find_by_login!(params[:id])

      render_404 if @user.deleted?

      @user_type = @user.user_type
    end
end
