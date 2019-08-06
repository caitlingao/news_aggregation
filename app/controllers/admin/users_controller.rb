module Admin
  class UsersController < Admin::ApplicationController
    def index
      @users = User.all
      if params[:q].present?
        qstr = "%#{params[:q].downcase}%"
        @users = @users.where("lower(login) LIKE ? or lower(email) LIKE ?", qstr, qstr)
      end
      @users = @users.order(id: :desc).page(params[:page])
    end

    def show
      @user = User.find(params[:id])
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.email = params[:user][:email]
      @user.login = params[:user][:login]

      if @user.update(params[:user].permit!)
        redirect_to(edit_admin_user_path(@user.id), notice: "User was successfully updated.")
      else
        render action: "edit"
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to(admin_users_url)
    end
  end
end
