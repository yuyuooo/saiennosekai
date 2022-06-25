class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
  end

  def show
    @user = User.find(params[:id])
    @crop_folders = @user.crop_folders
    @crop_folder = CropFolder.new
  end

  def about
    @user = User.find(params[:id])
  end


  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_about_path(@user), notice: "会員情報の登録内容を更新しました"
    else
      render "edit"
    end
  end

  def favorites
    @user = User.find(params[:id])
    @crop_folder = @user.crop_folders
    favorites = Favorite.where(user_id: @user.id).pluck(:crop_folder_id)
    @favorite_list = CropFolder.find(favorites)
  end

   private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_about_path(current_user)
    end
  end
end
