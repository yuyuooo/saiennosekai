class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
      @users = User.all.page(params[:page]).per(10)
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, success: "会員情報の編集が完了しました。"
    else
      render :edit
    end
  end
  
  def show
    @user = User.find(params[:id])
    @crop_folders = @user.crop_folders.all.order(created_at: :desc).page(params[:page]).per(5)
    @items = @user.items.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_active)
  end
end
