class CropFoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:create, :edit, :update, :destroy]

  def index
    @crop_folders = CropFolder.published
  end

  def show
    @crop_folder = CropFolder.find(params[:id])
    @crop_comment = CropComment.new
    @diary = Diary.new
    @user = User.find_by(id: params[:id])
  end

  def create
    @crop_folder = CropFolder.new(crop_folder_params)
    @crop_folder.user_id = current_user.id
    if @crop_folder.save
      redirect_to user_path(current_user), success: "栽培作物を投稿しました"
    else
      @user = current_user
      @crop_folders = @user.crop_folders.all
      render 'users/show'
    end
  end

  def edit
    @crop_folder = CropFolder.find(params[:id])
  end

  def update
    @crop_folder = CropFolder.find(params[:id])
    @user = User.find_by(id: params[:id])
    if @crop_folder.update(crop_folder_params)
    redirect_to user_path(@crop_folder.user), success: "作物の内容を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @crop_folder = CropFolder.find(params[:id])
    @crop_folder.destroy
    redirect_to user_path(@crop_folder.user), success: "栽培作物を削除しました"
  end

private

  def crop_folder_params
    params.require(:crop_folder).permit(:crop_name, :new_crop_date, :place, :memo, :is_published_flag, :is_active, :crop_image)
  end

  def ensure_correct_user
    @crop_folder = CropFolder.find(params[:id])
    unless @crop_folder.user == current_user
      redirect_to crop_folders_path
    end
  end

end
