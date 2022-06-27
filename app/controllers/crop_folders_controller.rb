class CropFoldersController < ApplicationController

  before_action :authenticate_user!


  def index
    @crop_folders = CropFolder.published
  end

  def show
    @crop_folder = CropFolder.find(params[:id])
    @crop_comment = CropComment.new
    @diary = Diary.new
    @user = User.find(params[:id])
  end

  def create
    @crop_folder = CropFolder.new(crop_folder_params)
    @crop_folder.user_id = current_user.id
    if @crop_folder.save
      redirect_to user_path(current_user)
    else
      @user = current_user
      @crop_folders = @user.crop_folders.all
      render 'users/show'
    end
  end

  def edit
  end

  def update
    if @crop_folder.update(crop_folder_params)
    redirect_to user_path(@crop_folder)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def crop_folder_params
    params.require(:crop_folder).permit(:crop_name, :new_crop_date, :place, :memo, :is_published_flag, :is_active)
  end

end
