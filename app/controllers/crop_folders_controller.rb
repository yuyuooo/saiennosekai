class CropFoldersController < ApplicationController

  before_action :authenticate_user!


  # def index
  #   @crop_folders = CropFolder.all
  # end

  def show
    @crop_folder = CropFolder.find(params[:id])
    @diary = Diary.new
  end

  def create
    @crop_folder = CropFolder.new(crop_folder_params)
    @crop_folder.user_id = current_user.id
    if @crop_folder.save
      redirect_to user_path(current_user)
    else
      @user = current_user
      @crop_folders = @user.crop_folders.all
      render 'user/show'
    end
  end

  private

  def crop_folder_params
    params.require(:crop_folder).permit(:crop_name, :new_crop_date, :place, :memo)
  end

end
