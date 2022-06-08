class CropFoldersController < ApplicationController

  before_action :authenticate_user!


  def index
    @crop_folder = CropFolder.new
    @crop_folders = CropFolder.all
  end

  def show
    @crop_folder = CropFolder.find(params[:id])
    @diary = Diary.new
  end

  def create
    @crop_folder = CropFolder.new(crop_folder_params)
    @crop_folder.user_id = current_user.id
    if @crop_folder.save
      redirect_to request.referer
    else
      @crop_folders = CropFolder.all
      render 'index'
    end
  end

  private

  def crop_folder_params
    params.require(:crop_folder).permit(:tytle, :weather, :body)
  end

end
